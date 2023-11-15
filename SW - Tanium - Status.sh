#!/bin/bash

# 1.1
# if the Tanium client is installed, get its version
# query launchctl, return "Running: version" if loaded or "Not Running: version"
# else return "Not Installed"
#
# TESTING
# reload:
#  launchctl bootstrap system /Library/LaunchDaemons/com.tanium.taniumclient.plist
# unload:
#  launchctl bootout system/com.tanium.taniumclient

taniumAgent="/Library/Tanium/TaniumClient/TaniumClient"

taniumPID=$(launchctl list | awk '/tanium/ { print $1 } ')

if [[ -n $taniumPID ]]; then
	status="Running"
else
	status="Not Running"
fi		

if [[ -e "${taniumAgent}" ]]; then
	version=$($taniumAgent --version)
	echo "<result>$status: $version</result>"

else

	echo "<result>Not Installed</result>"

fi

exit 0
