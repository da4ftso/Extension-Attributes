#!/bin/bash

taniumLaunchDaemon=$(ls /Library/LaunchDaemons/ | grep com.tanium.taniumclient.plist) # this really should be a grep or something

if [[ $taniumLaunchDaemon != '' ]]; then

	echo "<result>Installed</result>"

else

	echo "<result>Not Installed</result>"

fi

exit 0
