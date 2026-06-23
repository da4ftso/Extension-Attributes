#!/bin/bash

# 1.0 260623 PWC
# brew vulns clean output, maybe need printf?

# sample output:
# % ./brew_vulns_ea.sh
# <result>Critical: 0
# High: 4
# Medium: 2
# Low: 0
# Unknown: 1</result>

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

# brew installed?
if [ ! -x "$brewPath" ]; then
  echo "<result>Not Installed</result>"
  exit 0
fi

# count of vulnerabilities without CVE
vuln=$(sudo -u "$currentUser" $brewPath vulns | awk '
     BEGIN {     
      critical=0; high=0; medium=0; low=0; unknown=0
    }                

    /\(CRITICAL\)/ { critical++ }
    /\(HIGH\)/     { high++ }
    /\(MEDIUM\)/   { medium++ }
    /\(LOW\)/      { low++ }
    /\(UNKNOWN\)/  { unknown++ }

    END {
      printf "Critical: %d\nHigh: %d\nMedium: %d\nLow: %d\nUnknown: %d\n",
             critical, high, medium, low, unknown
    } ')

echo "<result>$vuln</result>"
