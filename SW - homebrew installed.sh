#!/bin/bash

# check for existence of homebrew
# old version, Intel (x86) only

if [ -f "/usr/local/bin/brew" ]; then
    echo "<result>Installed</result>"
else
    echo "<result>Not Installed</result>"
fi    
