#!/bin/bash

app="foo" # cask to get version info of

# borrowing brewPrefix from version EA

if [[ "$currentUser" = "" || "$currentUser" = "root" ]]; then
	asUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)
else
	asUser=$currentUser
fi
	
arch=$(/usr/bin/uname -m)

if [ "$arch" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"

else
  brewPrefix="/usr/local/bin"

fi

brewPath="$brewPrefix/brew"

if [ $? -eq 0 ]; then
  version=$($brewPath info "$app" | awk '/:/ { print $NF; exit }')
  echo "<result>$version</result>" # keep your numeric strings to numeric
else
    echo "<result></result>" # or "Not Installed" if that's your thing
fi
