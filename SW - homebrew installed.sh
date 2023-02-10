#!/bin/bash

# check for existence of homebrew

if [ -f "/usr/local/bin/brew" ] ; then
	result=$(/usr/local/bin/brew config | awk '/HOMEBREW_VERSION:/ { print $NF } ')
    echo "<result>Installed: "$result"</result>"

elif [ -f "/opt/homebrew/bin/brew" ] ; then
	result=$(/opt/homebrew/bin/brew config | awk '/HOMEBREW_VERSION:/ { print $NF } ')
    echo "<result>Installed: "$result"</result>"
    
else
    echo "<result>Not Installed</result>"
fi
