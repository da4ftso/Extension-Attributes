#!/bin/bash

# if you're looking for a script snippet, remember that wdutil requires sudo

# 1.4 240916 since RC, wdutil now returns 'redacted' so we have to parse the array regardless
# 1.3 240808 new version that supports 14+
# 1.2 230924 changed to NF and rm'd xargs
# 1.1 230830


SSID=$(/usr/libexec/PlistBuddy -c "Print :0:_items:spairport_airport_interfaces:spairport_airport_interfaces:spairport_current_network_information:spairport_current_network_information:_name" /dev/stdin <<< $(system_profiler SPAirPortDataType -xml) 2> /dev/null )
SSID=${SSID:1}

if [[ -z $SSID ]]; then
        echo "<result>Not Connected</result>"
else
        echo "<result>${SSID}</result>"
fi

exit 0
