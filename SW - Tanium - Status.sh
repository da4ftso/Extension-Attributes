#!/bin/bash

# TO-DO: let's combine this to check for not installed, not running, or running

taniumLaunchDaemon=$(ls /Library/LaunchDaemons/com.tanium.taniumclient.plist)

if [[ $taniumLaunchDaemon != '' ]]; then

	echo "<result>Installed</result>"

else

	echo "<result>Not Installed</result>"

fi

exit 0
