#!/bin/bash

# name and version for every installed brew cask
# spotify: 1.2.26

# variables
currentUser=$(/usr/bin/stat -f%Su "/dev/console")

if [ -z "$currentUser" ] || [ "$currentUser" == "root" ]; then
  currentUser=$(defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName 2>/dev/null)
fi

if [ -z "$currentUser" ]; then
  echo "Unable to get user"
  exit 0
fi

arch=$(/usr/bin/uname -m)

if [ "$arch" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"
else
  brewPrefix="/usr/local/bin"
fi

brewPath="$brewPrefix/brew"

# Check if brew is installed
if [ ! -x "$brewPath" ]; then
  echo "<result>Not Installed</result>"
  exit 0
fi

# list of installed casks
casks=$(sudo -u "$currentUser" $brewPath list --cask 2>/dev/null)

if [ -z "$casks" ]; then
  echo "<result>No Casks Installed</result>"
  exit 0
fi

# build output string with all casks and versions
output=""
while IFS= read -r cask; do
  # version info for each cask
  version=$(sudo -u "$currentUser" $brewPath info --cask "$cask" 2>/dev/null | awk -F'[()]' 'NF>1 {print $2 $3; exit}' )
  
  # empty version?
  if [ -z "$version" ]; then
    version="Unknown"
  fi
  
  # output
  if [ -z "$output" ]; then
#    output="$cask: $version"
    output="$version"
  else
#    output="$output, $cask: $version"
    output="$output, $version"
  fi
done <<< "$casks"

# results
echo "<result>$output</result>"
