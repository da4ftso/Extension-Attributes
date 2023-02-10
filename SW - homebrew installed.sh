#!/bin/bash

# check for existence of homebrew

if [[ -f "/usr/local/bin/brew" || -f "/opt/homebrew/bin/brew" ]]; then
    echo "<result>Installed: $(brew config | awk '/HOMEBREW_VERSION:/ { print $NF } ')</result>"
else
    echo "<result>Not Installed</result>"
fi
