#!/bin/sh

# with no awk, we'd get some crud:
#  Homebrew 4.1.15 Homebrew/homebrew-core (no Git repository) Homebrew/homebrew-cask (git revision 9d67b1d07b; last commit 2023-10-10)
#
# with awk $NF we'd get a partial:
#  repository)
#
# with awk $2 we (typically) get a usable value:
#   >=2.5.0 4.1.15 4.1.21


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
  result=$(sudo -u "$loggedInUser" "$brewPath" --version | awk ' { print $2 }' )

else
  result="" # change here if you'd prefer a label ie 'Not Installed'

fi

echo "<result>$result</result>"

exit 0
