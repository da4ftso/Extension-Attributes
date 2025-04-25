#!/bin/bash

# 1.0.5 250424 node versions

# running an EA from Jamf Pro runs as root, so we have to call brew based on the logged in account

result=""
loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")
architectureCheck=$(/usr/bin/uname -m)
currentUserHome=$(dscl . read /Users/"${loggedInUser}" NFSHomeDirectory | cut -d: -f 2 | sed 's/^ *//'| tr -d '\n')

# which node?
#  brew:     /opt/homebrew/bin/node
#  nvm/fnm:  /Users/userhome/.nvm/versions/node/v22.15.0/bin/node
#  pkg:      /usr/local/bin/node (arm64 included)

# installedNode=$(which node)

# brew node
if [ "$architectureCheck" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"
else
  brewPrefix="/usr/local/bin"
fi

brewPath="$brewPrefix/brew"

# Check for presence of target binary and get version.
if [ -e "$brewPath" ]; then
	info=$(sudo -u "$loggedInUser" "$brewPath" info node)
	if [[ $info == *"Not installed"* ]]; then
		result=""
	else	
		# sudo -u "$loggedInUser" "$brewPath" upgrade -f node
        # info=$(sudo -u "$loggedInUser" "$brewPath" info node)
		info=$(sudo -u "$loggedInUser" "$brewPath" info node)
    	result="$( echo "$info" | awk '/node:/ { print $2 " " $3 " " $4;exit }')"
    	result="${result//[!0-9.]/}" # bash only, if using zsh change this to sed
		echo "<result>brew: $result</result>"
		exit 0
	fi
fi

# npm node
if [ -e "${currentUserHome}"/.nvm/ ]; then
	latest=$(ls -r "${currentUserHome}"/.nvm/versions/node/ | awk ' { print $1; exit } ' )
	result=$("$currentUserHome"/.nvm/versions/node/"$latest"/bin/node -v)
	result="${result//[!0-9.]/}" # bash only, if using zsh change this to sed
	echo "<result>npm: $result</result>"
	exit 0
fi

# pkg node
if [ -e /usr/local/bin/node ]; then 
	result=$(/usr/local/bin/node -v)
 	result="${result//[!0-9.]/}"
  	echo "<result>pkg: $result</result>"
fi   
<result>pkg: 22.15.0</result>
