#!/bin/sh
​
computer=$(networksetup -getcomputername | awk '{print tolower($0)}')
group=APP_JAMF_Deployment_Test
​
dscl /Active\ Directory/CORPORATE/example.com -read /Groups/"$group" | grep "$computer"
​
if [ $? -eq 0 ];
then
    echo "<result>Yes</result>"
else
    echo "<result>No</result>"
fi