#!/bin/bash

# check for existence of homebrew

if [ -f "/usr/local/bin/brew" ] ; then

    echo "<result>Installed: $(/usr/local/bin/brew config | awk '/HOMEBREW_VERSION:/ { print $NF } ')</result>"

elif [ -f "/opt/homebrew/bin/brew" ] ; then

    echo "<result>Installed: $(/opt/homebrew/bin/brew config | awk '/HOMEBREW_VERSION:/ { print $NF } ')</result>"
    
else
    echo "<result>Not Installed</result>"
fi
