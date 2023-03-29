#!/bin/bash

# Description: Extension Attribute to report the installed version of the Nexthink agent, or Not Installed.

config="/Library/Application Support/Nexthink/config.json"

if [ -f "$config" ]; then

	VERSION=$( /bin/cat "$config" | awk -F\" '/version/ { print toupper($4)}' )

else

	VERSION="Not Installed"
fi

echo "<result>$VERSION</result>"
