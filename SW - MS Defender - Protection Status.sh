#!/bin/sh

# If Microsoft Defender is installed, then get ATP real-time protection status (true/false)
# real_time_protection_enabled                : true

# don't assume the mdatp symlink is present, go straight to the app

wdav="/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient"

if [ -f "$wdav" ]; then

    result=$( "$wdav" health --field real_time_protection_enabled )

    echo "<result>$result</result>"

else

    echo "<result>Not Installed</result>"

fi
