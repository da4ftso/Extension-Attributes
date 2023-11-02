#!/bin/bash

# TODO: check ShortVersionString, if empty check BundleVersion

plist="/Library/Printers/Canon/CUPSPS2/backend/backend.bundle/Contents/Info.plist"

if [[ -e $plist ]]; then

	version=$(/usr/bin/defaults read $plist | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>""$version""</result>"
    
else

	echo "<result>"Not Installed"</result>"
    
fi    

exit 0
