#!/bin/bash

# Get all hardware ports and their interfaces

interfaces=$(networksetup -listallhardwareports | awk '
/Hardware Port/ { port=substr($0, index($0, $3)) }
/Device/ { device=$2 }
/Ethernet Address/ {
    if (device != "") {
        cmd="ifconfig " device " | grep -q \"status: active\""
        exit_code = system(cmd)
        if (exit_code == 0) {
            print port " (" device ")"
        }
    }
}')

echo "<result>"$interfaces"</result>"
