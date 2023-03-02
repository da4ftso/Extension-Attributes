#!/bin/bash

app="$4" # add the usual to deal with ".app" or not

# assume $4 is in format of /path/name.app
# ie /Applications/Google Chrome.app
# see the Fancy version for intelligent handling of param $4

if [[ ${app} == "" ]]; then
  echo "No input provided, exiting..."
exit 1

# - find that other EA that had this done much more gracefully

plist="{$app}/Contents/Info.plist"

if [[ ! -e $plist ]]; then

	echo "<result>"Not Installed"</result>"

	exit 0 # do we need to exit here? why do I think this?
    
else
	version=$(/usr/bin/defaults read "$plist" | awk '/CFBundleVersion/ { print $NF } ' | tr -d '";')

	echo "<result>${version}</result>"

fi

exit 0
