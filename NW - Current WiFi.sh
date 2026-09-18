#!/bin/bash

# 15.7 apparently still returns <redacted>
# 26.0 currently returns the SSID name, something to watch for RC & beyond
# 26.0.1 and later started returning <redacted>
# this version correctly returns on 26.2+ incl 27.0
# credit to ZP and Dan K Snelson for the ipconfig setverbose

iface=$(scutil --nwi | grep -E -om1 'en\d') # egrep is deprecated

# /usr/sbin/ipconfig setverbose 1 - doesn't work in GG

ssid=$(ipconfig getsummary $iface | awk '/ SSID : / { print $NF } ')

if [ -z "$ssid" ]; then

        echo "No Wi-Fi detected"

else

        echo "<result>${ssid}</result>"

fi

/usr/sbin/ipconfig setverbose 0
