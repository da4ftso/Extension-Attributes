#!/bin/bash

# checks for brew; if present, checks for xz; if present, returns the version
# otherwise returns "Not Installed"
#
# https://access.redhat.com/security/cve/CVE-2024-3094

# runAsUser since otherwise Jamf will report this via the root user and give an inaccurate result
loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")

architectureCheck=$(/usr/bin/uname -m)

if [[ "$architectureCheck" = "arm64" ]]; then
  brewPrefix="/opt/homebrew/bin"

else
  brewPrefix="/usr/local/bin"

fi

brewPath="$brewPrefix/brew"

if [[ -e "$brewPath" ]]; then
  result=$(sudo -u "$loggedInUser" "$brewPath" list | grep xz)

  if [[ "$result" != "" ]]; then 
		version=$(sudo -u "$loggedInUser" $brewPath info xz | awk 'NR==1 { print $4 }')
		string="<result>Installed: $version</result>"
		string=$(echo "$string" | tr -d "\n" | tr -d "\r")
  		echo "$string"
        else
                echo "<result>Not Installed</result>"
  fi
fi
