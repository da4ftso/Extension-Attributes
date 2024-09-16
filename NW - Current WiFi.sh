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
    	ssid=$(/usr/libexec/PlistBuddy -c "Print :0:_items:spairport_airport_interfaces:spairport_airport_interfaces:spairport_current_network_information:spairport_current_network_information:_name" /dev/stdin <<< $(system_profiler SPAirPortDataType -xml) 2> /dev/null )
        echo "<result>${ssid}</result>"
        ;;

esac

exit 0
