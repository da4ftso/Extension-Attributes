#!/bin/bash

# return battery cycle count, or blank if not a portable
# use Integer as data type for better smart groups

hw=$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3, $4}') # MacBook Pro

if [[ $hw == MacBook* ]]; then
	count=$(system_profiler SPPowerDataType | awk '/Cycle Count:/ { print $NF }')
else
	count=""
fi

echo "<result>$count</result>"

exit 0
