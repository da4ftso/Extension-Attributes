#!/bin/bash

# Description: Extension Attribute to report the installed version of the Nexthink agent, or Not Installed.

config="/Library/Application Support/Nexthink/config.json"

if [ -f "$config" ]; then
	version=$(/usr/bin/awk '/version/ { print $NF } ' "$config" | tr -d '",' )
else
	version="Not Installed"
fi

echo "<result>$version</result>"
