#!/bin/sh

# If Microsoft Defender is installed, then get ATP definitions date
# return in YYYY-MM-DD format

# https://community.jamf.com/t5/jamf-pro/microsoft-defender-for-endpoint-for-mac-new-command-line-syntax/td-p/229110

# don't assume the mdatp symlink is present, go to the app

if [ -f "/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" ]; then

    # time long string: Oct 01, 2024 at 06:16:10 PM
    defString=$( "/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" health --field definitions_updated)

    # time string: 2024-10-01
    defShort=$(date -j -f "%b %d, %Y at %H:%M:%S %p" "$defString" +"%Y-%m-%d")

    # epoch time: 1727834086
    defEpoch=$(date -f "%Y-%m-%d" "$defShort" +"%s")

    currentDate=$(date +%s)

    difference=$((currentDate - defEpoch))

    days=$((difference / 86400))

    # result

    echo "<result>"$days"</result>"

else

    echo "<result>Not Installed</result>"

fi
