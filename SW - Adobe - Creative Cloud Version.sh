#!/bin/bash

# Description: Extension Attribute to report the installed version of Adobe Creative Cloud, or Not Installed.

# Since ACC doesn't install to /Applications we need an EA to report its version.

app=/Applications/Utilities/Adobe\ Creative\ Cloud/ACC/Creative\ Cloud.app/Contents/Info.plist

if [ -f "$app" ]; then
	version=$(/usr/bin/defaults read "$app" CFBundleShortVersionString)
else
	version="Not Installed"
fi

echo "<result>$version</result>"
