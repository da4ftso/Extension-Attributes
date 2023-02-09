#!/bin/bash

# report "1 day" if uptime is less than 1 day

uptimeRes=$(uptime)

if [ "$(echo "$uptimeRes" | grep day)" ]; then

	uptimeDays=$(echo "$uptimeRes" | awk ' { print $3 } ')

else

	uptimeDays=1
    
fi

echo "<result>$uptimeDays</result>"
