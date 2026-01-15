#!/bin/bash

# checks for .plist, returns New, Legacy or n/a

# variables

currentUser=$(/usr/bin/stat -f%Su "/dev/console")
currentUserHome=$(eval echo "~$currentUser")
plist="${currentUserHome}"/Library/Containers/com.microsoft.Outlook/Data/Library/Preferences/com.microsoft.Outlook.plist

if [ -f "${plist}" ] ; then
	mode=$(defaults read "${plist}" IsRunningNewOutlook)
    	if [ $mode = 1 ]; then
			result="New"
		else
			result="Legacy"
    	fi
else
    result="n/a"
fi

echo "<result>$result</result>"
