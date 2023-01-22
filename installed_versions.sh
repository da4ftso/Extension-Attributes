#!/bin/bash

# https://www.jamf.com/jamf-nation/discussions/37944/installed-macos-updates-into-an-extension-attribute#responseChild212185

product_names=$(system_profiler SPInstallHistoryDataType -json | awk -F'"' '/_name/{print $4}')
install_dates=($(system_profiler SPInstallHistoryDataType -json | awk -F'"' '/install_date/{print $4}'))

i=0
while read item; do
    if [[ "$item" =~ ^"macOS" ]]; then
        install_date_raw="${install_dates[$i]}"
        install_date_formatted=$(date -jf "%Y-%m-%d"T"%T"Z "$install_date_raw" +"%D %l:%M %p")
        list+=("${item}")
        list+=("Installed: ${install_date_formatted}")
    fi
    let i=$((i+1))
done < <(echo "$product_names")

echo "<result>$(printf '%s\n' "${list[@]}")</result>"