#!/bin/bash

# https://www.jamf.com/jamf-nation/discussions/37944/installed-macos-updates-into-an-extension-attribute#responseChild212185
#
# this will return something like:
#
# <result>macOS 12.0.1
# Installed: 11/15/21  5:58 AM
# macOS 12.0.1
# Installed: 03/15/22  3:33 PM
# macOS 12.3
# Installed: 03/15/22  4:18 PM</result>


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
