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

# TO-DO: 
# - sort /Applications
# - check if CFBundleVersion is empty, try to read CFShortBundleVersion instead
# - validate this against App.app, App 2.app, etc etc
# - find that other EA that had this done much more gracefully

plist="{$app}/Contents/Info.plist"

if [[ ! -e $plist ]]; then

	echo "<result>"Not Installed"</result>"

	exit 0
    
else
	version=$(/usr/bin/defaults read "$plist" | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>${version}</result>"

fi

exit 0
