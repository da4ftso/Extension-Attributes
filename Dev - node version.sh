#!/bin/bash

# 1.0.6 250428 node versions

# running an EA from Jamf Pro runs as root, so we have to call brew based on the logged in account

result=""
currentUser=$(/usr/bin/stat -f%Su "/dev/console")
currentUserHome=$(eval echo "~$currentUser")
# currentUserHome=$(dscl . read /Users/"${currentUser}" NFSHomeDirectory | cut -d: -f 2 | sed 's/^ *//'| tr -d '\n')
architectureCheck=$(/usr/bin/uname -m)

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
	info=$(sudo -u "$currentUser" "$brewPath" info node)
	if [[ $info == *"Not installed"* ]]; then
		result=""
	else	
		# sudo -u "$currentUser" "$brewPath" upgrade -f node
        # info=$(sudo -u "$currentUser" "$brewPath" info node)
		info=$(sudo -u "$currentUser" "$brewPath" info node)
    	result="$( echo "$info" | awk '/node:/ { print $2 " " $3 " " $4;exit }' | tr -d '\r')"
    	result="${result//[!0-9.]/}" # bash only, if using zsh change this to sed
		echo "<result>brew: $result</result>"
		exit 0
	fi
fi

# npm node
if [ -e "${currentUserHome}"/.nvm/ ]; then
	latest=$(ls -r "${currentUserHome}"/.nvm/versions/node/ | awk ' { print $1; exit } ' )
	result=$("$currentUserHome"/.nvm/versions/node/"$latest"/bin/node -v | tr -d '\r')
	result="${result//[!0-9.]/}" # bash only, if using zsh change this to sed
	echo "<result>npm: $result</result>"
	exit 0
fi

# pkg node
if [ -e /usr/local/bin/node ]; then 
	result=$(/usr/local/bin/node -v | tr -d '\r')
 	result="${result//[!0-9.]/}"
  	echo "<result>pkg: $result</result>"
fi   
