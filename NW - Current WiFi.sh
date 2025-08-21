#!/bin/bash

# 15.7 apparently still returns <redacted>
# 26.0 currently returns the SSID name, something to watch for RC & beyond

osProductVersion=$( /usr/bin/sw_vers -productVersion )


case "${osProductVersion}" in

    12* | 13* | 14* )
		wifi=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2)
		ssid=$(networksetup -getairportnetwork "$wifi" | awk -F': ' '{ print $NF;exit }')
		echo "<result>${ssid}</result>"
        ;;

    15* )
    	ssid=$(/usr/libexec/PlistBuddy -c "Print :0:_items:spairport_airport_interfaces:spairport_airport_interfaces:spairport_current_network_information:spairport_current_network_information:_name" /dev/stdin <<< $(system_profiler SPAirPortDataType -xml) 2> /dev/null )
        echo "<result>${ssid}</result>"
        ;;
	26* )
		ssid=$(/usr/bin/wdutil info | grep -w SSID | sed 's/.*\: //')
		echo "<result>${ssid}</result>"
		;;        
esac

exit 0
