#!/bin/bash

uuid=$(
    ioreg -rd1 -c IOPlatformExpertDevice |
    awk -F'"' '/IOPlatformUUID/{print $4}'
)

if [[ -z "$uuid" ]]; then
    echo "<result>Unavailable</result>"
    exit 0
fi

plist="/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${uuid}.plist"

if [[ ! -f "$plist" ]]; then
    echo "<result>Unavailable</result>"
    exit 0
fi

# plutil -extract works with XML and binary property lists.
# status=$(plutil -extract LocationServicesEnabled raw -o - "$plist" 2>/dev/null)

# awk works reliably on 27
status=$(plutil -p /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${uuid}.plist | awk '/LocationServicesEnabled/ { print $NF }')

case "$status" in
    1|true|TRUE|yes)
        result="Enabled"
        ;;
    0|false|FALSE|no)
        result="Disabled"
        ;;
    *)
        result="Unavailable"
        ;;
esac

echo "<result>${result}</result>"
