#!/bin/bash

# for a solution that reports version or Not Installed:
# https://github.com/da4ftso/Extension-Attributes/blob/master/SW%20-%20Tanium%20-%20Version.sh

taniumLaunchDaemon=$(ls /Library/LaunchDaemons/com.tanium.taniumclient.plist)

if [[ $taniumLaunchDaemon != '' ]]; then

	echo "<result>Installed</result>"

else

	echo "<result>Not Installed</result>"

fi

exit 0
