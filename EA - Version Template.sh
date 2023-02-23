#!/bin/bash

app="$4" # add the usual to deal with ".app" or not

# did $4 contain .app?
# if $app != *.app
# did $4 contain a path?
# if $app != "/Applications/"*
# did $4 contain a path that wasn't /Applications/ ?
#  - mdfind, bail out if no match with .app ?
#
# or use =~ ?

# if [[ ${app} == "" ]]; then
#	echo "No input provided, exiting..."
#	exit 1

app=""

if [[ "$app" =~ ".app" ]]; then
	echo "contains .app"
else
	app="$app".app
fi

# TO-DO: sort /Applications

plist="{$app}/Contents/Info.plist"

if [[ ! -e $plist ]]; then

	echo "<result>"Not Installed"</result>"

	exit 0
    
else
	version=$(/usr/bin/defaults read "$plist" | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>${version}</result>"

fi

exit 0
