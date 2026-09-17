#!/bin/bash

# Jamf Pro Extension Attribute: Apple Account / iCloud sign-in status
#
# Result values:
#   Yes       Strong local evidence of an iCloud account
#   Likely    One non-authoritative local artifact was found
#   No        No evidence found on macOS versions where MobileMeAccounts is
#             still expected to exist
#   Unknown   No evidence found on macOS 27 or later; Apple does not expose a
#             supported command-line/API equivalent of the System Settings UI
#   No User   No GUI user is currently logged in
#
# Local testing:
#   ./icloud_account_status_ea.sh
#   ./icloud_account_status_ea.sh --verbose

set -u

verbose=0
case "${1:-}" in
    -v|--verbose) verbose=1 ;;
    "") ;;
    *)
        echo "Usage: $0 [-v|--verbose]" >&2
        exit 2
        ;;
esac

log_verbose() {
    if [[ "$verbose" -eq 1 ]]; then
        printf '%s\n' "$*" >&2
    fi
}

print_result() {
    printf '<result>%s</result>\n' "$1"
}

console_user=$(/usr/bin/stat -f '%Su' /dev/console 2>/dev/null)

if [[ -z "$console_user" || "$console_user" == "root" || \
      "$console_user" == "loginwindow" || "$console_user" == "_mbsetupuser" ]]; then
    log_verbose "No logged-in GUI user was found."
    print_result "No User"
    exit 0
fi

console_uid=$(/usr/bin/id -u "$console_user" 2>/dev/null)
if [[ -z "$console_uid" ]]; then
    log_verbose "Could not resolve the UID for $console_user."
    print_result "Unknown"
    exit 0
fi

current_uid=$(/usr/bin/id -u)

run_as_console_user() {
    if [[ "$current_uid" -eq "$console_uid" ]]; then
        "$@"
    elif [[ "$current_uid" -eq 0 ]]; then
        /bin/launchctl asuser "$console_uid" \
            /usr/bin/sudo -u "$console_user" -- "$@"
    else
        return 77
    fi
}

product_version=$(/usr/bin/sw_vers -productVersion 2>/dev/null)
product_major=${product_version%%.*}
case "$product_major" in
    ''|*[!0-9]*) product_major=0 ;;
esac

home_directory=$(/usr/bin/dscl . -read "/Users/$console_user" NFSHomeDirectory 2>/dev/null | \
    /usr/bin/sed 's/^[^:]*:[[:space:]]*//')
if [[ -z "$home_directory" || ! -d "$home_directory" ]]; then
    log_verbose "Could not resolve an accessible home folder for $console_user."
    print_result "Unknown"
    exit 0
fi

legacy_account=0
account_store_artifact=0
keychain_artifact=0

# Read through cfprefsd in the user's GUI context, rather than trusting only the
# on-disk plist. The shell performs the redirection, so this also works when the
# command itself is run as the console user.
legacy_export=$(/usr/bin/mktemp -t icloud-account-ea.XXXXXX)
if run_as_console_user /usr/bin/defaults export MobileMeAccounts - \
    > "$legacy_export" 2>/dev/null; then
    account_index=0
    while :; do
        account_id=$(/usr/libexec/PlistBuddy \
            -c "Print :Accounts:$account_index:AccountID" \
            "$legacy_export" 2>/dev/null) || break

        if [[ -n "$account_id" ]]; then
            legacy_account=1
            break
        fi
        account_index=$((account_index + 1))
    done
fi
/bin/rm -f "$legacy_export"

# Newer releases maintain per-user iCloud account state here. Its presence is
# useful corroborating evidence, but by itself is not treated as authoritative
# because local account artifacts can survive a sign-out or incomplete setup.
icloud_accounts_path="$home_directory/Library/Application Support/iCloud/Accounts"
if [[ -d "$icloud_accounts_path" ]]; then
    for account_item in \
        "$icloud_accounts_path"/* \
        "$icloud_accounts_path"/.[!.]* \
        "$icloud_accounts_path"/..?*; do
        if [[ -e "$account_item" ]]; then
            account_store_artifact=1
            break
        fi
    done
fi

# Query only for Keychain item metadata; do not request or print its secret.
if run_as_console_user /usr/bin/security find-generic-password \
    -s 'com.apple.gs.appleid.auth' >/dev/null 2>&1; then
    keychain_artifact=1
fi

log_verbose "User: $console_user (UID $console_uid)"
log_verbose "macOS: ${product_version:-unknown}"
log_verbose "MobileMeAccounts record: $legacy_account"
log_verbose "iCloud Accounts artifact: $account_store_artifact"
log_verbose "Apple Account Keychain artifact: $keychain_artifact"

if [[ "$legacy_account" -eq 1 ]]; then
    print_result "Yes"
elif [[ "$account_store_artifact" -eq 1 && "$keychain_artifact" -eq 1 ]]; then
    print_result "Yes"
elif [[ "$account_store_artifact" -eq 1 || "$keychain_artifact" -eq 1 ]]; then
    print_result "Likely"
elif [[ "$product_major" -ge 27 ]]; then
    print_result "Unknown"
else
    print_result "No"
fi

exit 0
