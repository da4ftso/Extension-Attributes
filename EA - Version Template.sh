#!/bin/bash

app="$4" # add the usual to deal with ".app" or not

# did $4 contain .app?
# if $app != *.app
# did $4 contain a path?
# if $app != "/Applications/"*
# did $4 contain a path that wasn't /Applications/ ?
#
# or use =~ ?

plist="{$app}/Contents/Info.plist"

if [[ ! -e $plist ]]; then

	echo "<result>"Not Installed"</result>"

	exit 0
    
else
	version=$(/usr/bin/defaults read "$plist" | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>${version}</result>"

fi

exit 0
