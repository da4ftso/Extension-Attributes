#!/bin/bash

# 1.0.1 250424 PWC node versions
#  ditch the else under brew node check?

loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")
architectureCheck=$(/usr/bin/uname -m)

# which node?
#  brew:     /opt/homebrew/bin/node
#  nvm/fnm:  /Users/userhome/.nvm/versions/node/v22.15.0/bin/node

installedNode=$(which node)

# brew node
# brewNodex() {
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
		# sudo -u "$loggedInUser" "$brewPath" upgrade -f node
        info=$(sudo -u "$loggedInUser" "$brewPath" info node)
    	result="$( echo "$info" | awk '/node:/ { print $2 " " $3 " " $4;exit }')"
    	
    	fi

else
  result="" # change here if you'd prefer a label ie 'Not Installed'

fi
# }

# npm node
# npmNode{} (
if [ -e "${loggedInUser}"/.nvm/ ]; then
   result=$(sudo -u "$loggedInUser" node -v)
fi   
# )

# if brew node vs npm node, get $result

result="${result//[!0-9.]/}" #bash only, if using zsh change this to sed

echo "<result>$result</result>"

exit 0
