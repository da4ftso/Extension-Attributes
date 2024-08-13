#!/bin/bash

# Report current SSID, or "None"

osProductVersion=$( /usr/bin/sw_vers -productVersion )


case "${osProductVersion}" in

    12* | 13* | 14* )
	wifi=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2)
	ssid=$(networksetup -getairportnetwork "$wifi" | awk -F': ' '{ print $NF;exit }')
    		if [[ $ssid == *"not associated"* ]]; then
		ssid="None"
		fi
	echo "<result>${ssid}</result>"
        ;;

    15* )
    	ssid=$(wdutil info | awk -F: '/SSID/ { print $NF;exit } ') ; ssid=${ssid:1}
        echo "<result>${ssid}</result>"
        ;;

esac

exit 0
