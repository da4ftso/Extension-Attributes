#!/bin/sh
​
# change GROUPNAME and DOMAIN

computer=$(networksetup -getcomputername | awk '{print tolower($0)}')
group=GROUPNAME
​
dscl /Active\ Directory/DOMAIN/example.com -read /Groups/"$group" | grep "$computer"
​
if [ $? -eq 0 ];
then
    echo "<result>Yes</result>"
else
    echo "<result>No</result>"
fi
