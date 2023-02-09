#!/bin/bash

# as an EA, no need to sudo this, or have a root check

taniumVersion=$(/Library/Tanium/TaniumClient/TaniumClient --version)

if [[ $taniumVersion != '' ]]; then

	echo "<result>$taniumVersion</result>"

else

	echo "<result>Not Installed</result>"

fi

exit 0
