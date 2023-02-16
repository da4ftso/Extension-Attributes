#!/bin/bash

# returns a string value
# for numeric result, use OS - Uptime

lastReboot=$(last | awk '/reboot/ { print $4" "$5 } ' | head -n 1)\

echo "<result>$lastReboot</result>"
