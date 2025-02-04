#!/bin/bash

# 1.1 250128 PWC Happy Five O'Clock Day, 312!

# This version now iterates through all Edge profiles and reports the profile and
# the email address signed in. If Edge has never been used, this will return nothing.

# Since jq is now included by default on macOS we can use that more effectively
# then trying to parse the JSON with awk.

# Setting IFS Env to only use new lines as field seperator 
IFS=$'\n'

# should probably bail out if jq not found

currentUser=$(/usr/bin/stat -f%Su "/dev/console")
lastUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

if [[ "$currentUser" = "" || "$currentUser" = "root" ]]
    then userHome=$(/usr/bin/dscl . -read /Users/"$lastUser" NFSHomeDirectory | awk -F ": " '{print $2}')
    else userHome=$(/usr/bin/dscl . -read /Users/"$currentUser" NFSHomeDirectory | awk -F ": " '{print $2}')
fi

getEmail() {
for Preferences in $(find "${userHome}"/Library/Application\ Support/Microsoft\ Edge/*/Preferences )
	do
		email=$(jq -r '.account_info[0].email' $Preferences )
			if [ $email != "null" ]; then
				profileName=$(echo $Preferences | awk -F'/' '/Edge/ { print $7 }' )
				echo $profileName": "$email
			fi	
	done
}

if [ -d "${userHome}"/Library/Application\ Support/Microsoft\ Edge/ ]; then
	result="$(getEmail)"
else
	result=""
fi		

echo "<result>"$result"</result>"
