#!/bin/sh

# 1.1 230830
# returns "Off" if Wi-Fi is off
# deprecated as of 14 (?)

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | /usr/bin/awk '/SSID: / { $1 = "" ; print $0 }') | tr -d '/n' | xargs

if [[ -z $SSID ]]; then
	echo "<result>Not Connected</result>"
else
	echo "<result>${SSID}</result>"
fi

exit 0
