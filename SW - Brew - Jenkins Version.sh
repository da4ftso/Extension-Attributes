#!/bin/bash

# brew info jenkins, return version if installed or blank if not
# https://nvd.nist.gov/vuln/detail/CVE-2024-23897

loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")

architectureCheck=$(/usr/bin/uname -m)

if [ "$architectureCheck" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"

else
  brewPrefix="/usr/local/bin"

fi

brewPath="$brewPrefix/brew"

# Check for presence of target binary and get version.

if [ -e "$brewPath" ]; then

	info=$(sudo -u "$loggedInUser" "$brewPath" info jenkins)

		if [[ $info == *"Installed"* ]]; then
	
    	result="$( echo $info | awk '/jenkins:/ { print $2 " " $3 " " $4;exit }')"
    	
    	fi

else
  result="" # change here if you'd prefer a label ie 'Not Installed'

fi

echo "<result>$result</result>"

exit 0
