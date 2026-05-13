#!/bin/bash

# with no awk, we'd get lots of crud:
#  Homebrew 4.1.15 Homebrew/homebrew-core (no Git repository) Homebrew/homebrew-cask (git revision 9d67b1d07b; last commit 2023-10-10)
#
# with awk $2 we (typically) get a usable value:
#   >=2.5.0
#   3.2.14 (git (git
#   4.0.18 2023-01-18) 2023-05-19)
#   4.1.21
#
# sed to remove the crud.

# 1.9 - consolidated awk+sed -> sed

currentUser=$(/usr/bin/stat -f%Su "/dev/console")
# lastUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

# if current = "" or = "root" etc
# then change to asUser

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

# Check for presence of target binary and get version.

if [[ -e "$brewPath" ]]; then
  result=$(sudo -u "$asUser" "$brewPath" -v | sed -En 's/Homebrew[[:space:]]+([0-9.]+).*/\1/p' )

else
  result="" # change here if you'd prefer a label ie 'Not Installed'

fi

echo "<result>$result</result>"

exit 0
