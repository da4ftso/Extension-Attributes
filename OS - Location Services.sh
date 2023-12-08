#!/bin/bash

uuid=$(system_profiler SPHardwareDataType | grep "Hardware UUID" | awk '{print $3}')
domain="/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${uuid}"
plist="${domain}.plist"

sw_vers=$(sw_vers -productVersion | awk -F. '{print $1}') # 14 for Sonoma, eg

if [[ -f "${plist}" ]]
then
	if [ "$sw_vers" -gt "11" ]
	then
	        status=$(plutil -p "${plist}" | awk '/LocationServicesEnabled/ {print $NF}')
	else
                status=$(defaults read "${plist}" LocationServicesEnabled)
        fi
    if [[ "${status}" == "1" ]]
    then
        result="Enabled"
    else
        result="Disabled"
    fi
else
    result="Unavailable"
fi

echo "<result>${result}</result>"
