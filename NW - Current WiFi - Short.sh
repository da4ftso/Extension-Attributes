#!/bin/bash

# if you're looking for a script snippet, remember that wdutil requires sudo

# 1.3 240808 new version that supports 14+
# 1.2 230924 changed to NF and rm'd xargs
# 1.1 230830

SSID=$(wdutil info | awk -F: '/SSID/ { print $NF;exit } ')
SSID=${SSID:1}

if [[ -z $SSID ]]; then
        echo "<result>Not Connected</result>"
else
        echo "<result>${SSID}</result>"
fi

exit 0
