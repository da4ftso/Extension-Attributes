#!/bin/bash

# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html

currentUser=$(/usr/bin/stat -f%Su "/dev/console")
currentUserHome=$(eval echo "~$currentUser")

if [ -d "$currentUserHome/Library/Application\ Support/Google/Chrome/Default/OptGuideOnDeviceModel" ] ; then
    echo "<result>Installed</result>"
else
    echo "<result>Not Installed</result>"
fi
