#!/bin/bash

# TO-DO: loop through multiple profiles

# Setting IFS Env to only use new lines as field seperator 
IFS=$'\n'

currentUser=$(/usr/bin/stat -f%Su "/dev/console") # pete
lastUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

if [[ "$currentUser" = "" || "$currentUser" = "root" ]]
    then userHome=$(/usr/bin/dscl . -read /Users/"$lastUser" NFSHomeDirectory | awk -F ": " '{print $2}')
    else userHome=$(/usr/bin/dscl . -read /Users/"$currentUser" NFSHomeDirectory | awk -F ": " '{print $2}') # /Users/pete
fi

if grep -q gaia "${userHome}"/Library/Application\ Support/Microsoft\ Edge/Default/Preferences ; then
	echo "An account is signed in to Edge..."
else
	echo "No sign-in detected..."
fi	
