#!/bin/bash

# 1.1.1 230626 PWC
# brew vulns EA-friendly output: use user's shell to find/run brew, strip ANSI colors,
# and use case-insensitive awk matching.

# variables
currentUser=$(/usr/bin/stat -f%Su "/dev/console")

if [ -z "$currentUser" ] || [ "$currentUser" == "root" ]; then
  currentUser=$(defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName 2>/dev/null)
fi

if [ -z "$currentUser" ]; then
  echo "Unable to get user"
  exit 0
fi

# Try to find brew in the user's environment (this helps when Jamf runs as root but brew is in user's PATH)
userBrewPath=$(sudo -u "$currentUser" bash -lc 'command -v brew 2>/dev/null' || true)

# Fallback if not found via user's shell
if [ -n "$userBrewPath" ]; then
  brewPath="$userBrewPath"
else
  arch=$(/usr/bin/uname -m)
  if [ "$arch" = "arm64" ]; then
    brewPrefix="/opt/homebrew/bin"
  else
    brewPrefix="/usr/local/bin"
  fi
  brewPath="$brewPrefix/brew"
fi

# brew installed?
if [ ! -x "$brewPath" ]; then
  echo "<result>Not Installed</result>"
  exit 0
fi

# Run brew vulns as the user (using their shell), strip ANSI color codes, then count severities case-insensitively.
vuln=$(sudo -u "$currentUser" bash -lc "'${brewPath}' vulns 2>/dev/null || true" \
  | sed -E $'s/\x1B\\[[0-9;]*[mK]//g' \
  | awk '
    BEGIN {
      IGNORECASE = 1
      critical = 0; high = 0; medium = 0; low = 0; unknown = 0
    }
    /CRITICAL/ { critical++ }
    /HIGH/     { high++ }
    /MEDIUM/   { medium++ }
    /LOW/      { low++ }
    /UNKNOWN/  { unknown++ }
    END {
      printf "Critical: %d\nHigh: %d\nMedium: %d\nLow: %d\nUnknown: %d\n",
             critical, high, medium, low, unknown
    }')

# Output for Jamf EA
echo "<result>$vuln</result>"
