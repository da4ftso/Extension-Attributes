#!/bin/sh

# Check to see if a VirtualBox Extension Pack is installed

# original: https://www.jamf.com/jamf-nation/discussions/27444/virtualbox-extension-pack

if [ -e /Applications/VirtualBox.app/Contents/MacOS/ExtensionPacks/Oracle_VM_VirtualBox_Extension_Pack/ExtPack.xml ] ; then
    echo "<result>$(/bin/cat /Applications/VirtualBox.app/Contents/MacOS/ExtensionPacks/Oracle_VM_VirtualBox_Extension_Pack/ExtPack.xml | awk -F '[<>"]' '/<Version/ { print $5 }')</result>"
else
    echo "<result>No</result>"
fi

exit 0
