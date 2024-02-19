#!/bin/sh

# with no awk, we'd get some crud:
#  Homebrew 4.1.15 Homebrew/homebrew-core (no Git repository) Homebrew/homebrew-cask (git revision 9d67b1d07b; last commit 2023-10-10)
#
# with awk $2 we (typically) get a usable value:
#   >=2.5.0
#   3.2.14 (git (git
#   4.0.18 2023-01-18) 2023-05-19)
#   4.1.21
#
# sed to remove the crud.

# runAsUser since otherwise Jamf will report this via the root user and give an inaccurate result
loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")

# -m for (machine) hardware type; could use -p instead
architectureCheck=$(/usr/bin/uname -m)

if [ "$architectureCheck" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"

else
  brewPrefix="/usr/local/bin"

fi

brewPath="$brewPrefix/brew"

# Check for presence of target binary and get version.

if [ -e "$brewPath" ]; then
  result=$(sudo -u "$loggedInUser" "$brewPath" --version | awk ' { print $2 }' | sed 's/[ -].*//' ) # catch the -dirty and (git etc

else
  result="" # change here if you'd prefer a label ie 'Not Installed'

fi

echo "<result>$result</result>"

exit 0
