#!/bin/bash

# Extension Attribute to report the installed version of the Nexthink agent, or Not Installed.

if [ -f "/Library/Application Support/Nexthink/config.json" ]; then

	version=$( /bin/cat "/Library/Application Support/Nexthink/config.json" | awk '/version/ { print $NF }' | tr -d '",' )

else

	version="Not Installed"

fi

echo "<result>$version</result>"
