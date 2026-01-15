#!/bin/bash

# obviously this should've been named 'Will It Blend' but reasons

# from userspace and root: /bin/launchctl list | /usr/bin/awk '{print substr($0, index($0, $3))}' | /usr/bin/sed '1d' | grep -v apple | sort
#
# use this to determine everything required for day to day
# then use this EA to check whether it's loaded

# variables

currentUser=$(/usr/bin/stat -f%Su "/dev/console")
uid=$(id -u $currentUser)
plistPath="$4"

if [[ -z "$4" ]]; then
  plistPath="/path/to/your.plist" # hardcode here
fi 

if /bin/launchctl list | grep -q "$plistPath" ; then # https://www.shellcheck.net/wiki/SC2143
	echo "<result>$plistPath job is loaded.</result>"
else
	echo "<result>$plistPath job is not loaded.</result>"
fi
