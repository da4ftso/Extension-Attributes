#!/bin/sh

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
  result=$(sudo -u "$loggedInUser" "$brewPath" -v | awk '{ print $NF } ')

else
  result=""

fi

echo "<result>$result</result>"

exit 0
