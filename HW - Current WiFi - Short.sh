#!/bin/sh

# returns "Off" if Wi-Fi is off

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | /usr/bin/grep -w 'AirPort\|SSID' | /usr/bin/awk -F ": " '{print $2}')

if [[ -z $SSID ]]; then
	echo "<result>Not Connected</result>"
else
	echo "<result>${SSID}</result>"
fi

exit 0
