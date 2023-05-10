#!/bin/bash

# call scutil to look for system-level VPN connections
# consider filtering out 'PPP' for device serial modems and other small peripherals
# typically using this to look for things like Nord, Fortigate, Proton

vpns=$(/usr/sbin/scutil --nc list | sed '1d')

if [[ ${vpns} = *LPSS* ]]; then

	echo "<result></result>"

else

	echo "<result>${vpns}</result>"

fi

exit 0
