#!/bin/bash

app="$4" # add the usual to deal with ".app" or not

# did $4 contain .app?
# did $4 contain a path?
# did $4 contain a path that wasn't /Applications/ ?

plist="{$app}/Contents/Info.plist"

if [[ ! -e $plist ]]; then

	echo "<result>"Not Installed"</result>"

	exit 0
    
else
	version=$(/usr/bin/defaults read "$plist" | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>${version}</result>"

fi

exit 0
