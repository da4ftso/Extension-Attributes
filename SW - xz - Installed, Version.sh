#/bin/bash

# https://access.redhat.com/security/cve/CVE-2024-3094

architectureCheck=$(/usr/bin/uname -m)

if [ "$architectureCheck" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"

else
  brewPrefix="/usr/local/bin"

fi

brewPath="$brewPrefix/brew"

"$brewPath" list | /usr/bin/grep xz

if [ $? -eq 0 ]; then
  version=$(brew info xz | awk 'NR==1 {print $4}')
  echo "<result>Installed: $version</result>"
else
  echo "<result>Not Installed</result>"
fi
