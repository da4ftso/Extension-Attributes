#!/bin/sh

# If Microsoft ATP is installed, then get tamper protection status:
#
# disabled – tamper protection is completely off.
# audit – tampering operations are logged, but not blocked.
# block – tamper protection is on, tampering operations are blocked.

if [ -f "/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" ]; then

    result=$("/Applications/Microsoft Defender.app/Contents/Resources/Tools/wdavdaemonclient" health --field tamper_protection | sed 's/"//g')

    echo "<result>$result</result>"

else

    echo "<result>Not Installed</result>"

fi
