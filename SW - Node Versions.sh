#!/bin/bash

# node versions
# 1.1 260424

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
declare -a nodeVersions=()

# Brew node
if [ -e "$brewPath" ]; then
    info=$(sudo -u "$loggedInUser" "$brewPath" info node 2>/dev/null)
    if [[ $info != *"Not installed"* ]]; then
        result=$( echo "$info" | awk '/node:/ { print $2 " " $3 " " $4;exit }' | tr -d '\r')
        result="${result//[!0-9.]/}"
        [ -n "$result" ] && nodeVersions+=("brew: $result")
    fi
fi

# NVM node
nvm_node_path="${currentUserHome}/.nvm/versions/node/$(ls -r "${currentUserHome}"/.nvm/versions/node/ 2>/dev/null | awk 'NR==1')/bin/node"
if [ -x "$nvm_node_path" ]; then
    result=$("$nvm_node_path" -v 2>/dev/null | tr -d '\r' | sed 's/[^0-9.]//g')
    [ -n "$result" ] && nodeVersions+=("nvm: $result")
fi

# PKG node
if [ -x /usr/local/bin/node ]; then
    result=$(/usr/local/bin/node -v 2>/dev/null | tr -d '\r' | sed 's/[^0-9.]//g')
    [ -n "$result" ] && nodeVersions+=("pkg: $result")
fi

# Output all detected versions
if [ ${#nodeVersions[@]} -eq 0 ]; then
    echo "<result>Not installed</result>"
else
    echo "<result>$(IFS='; '; echo "${nodeVersions[*]}")</result>"
fi
