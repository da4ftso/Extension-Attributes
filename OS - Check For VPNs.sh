#!/bin/bash

vpns=$(/usr/sbin/scutil --nc list | sed '1d')

if [[ ${vpns} = *LPSS* ]]; then

	echo "<result></result>"

else

	echo "<result>${vpns}</result>"

fi

exit 0