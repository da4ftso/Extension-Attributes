#!/bin/sh

# If Microsoft Defender is installed, then get ATP definitions date
# return in YYYY-MM-DD format

# https://community.jamf.com/t5/jamf-pro/microsoft-defender-for-endpoint-for-mac-new-command-line-syntax/td-p/229110

# don't assume the mdatp symlink is present, go to the app

if [ -f "/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" ]; then

    result=$( "/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" health --field definitions_updated)

    dateresult=$(date -j -f "%b %d, %Y at %H:%M:%S %p" "$result" +"%Y-%m-%d")

    echo "<result>$dateresult</result>"

else

    echo "<result>Not Installed</result>"

fi
