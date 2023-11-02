#!/bin/bash

# would love to do this with ioreg instead?

device=$(/usr/sbin/system_profiler SPUSBDataType 2>&1 | grep "Manufacturer: DisplayLink")

if [[ $device != "" ]]; then
	echo "<result>Connected</result>"
else
	echo "<result>Not Connected</result>"
fi

exit 0
