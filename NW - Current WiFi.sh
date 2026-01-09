#!/bin/bash

# 15.7 apparently still returns <redacted>
# 26.0 currently returns the SSID name, something to watch for RC & beyond
# 26.0.1 and later started returning <redacted>
# this version correctly returns on 26.2 and 26.3b1
# credit to ZP and Dan K Snelson for the ipconfig setverbose

# file Feedback with Apple as to why this needs to be set via MDM!

iface=$(scutil --nwi | grep -E -om1 'en\d') # egrep is deprecated

/usr/sbin/ipconfig setverbose 1

ssid=$(ipconfig getsummary $iface | awk '/ SSID : / { print $NF } ')

if [ -z "$ssid" ]; then

        echo "No Wi-Fi detected"

else

        echo "<result>${ssid}</result>"

fi

/usr/sbin/ipconfig setverbose 0
