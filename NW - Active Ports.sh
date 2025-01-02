#!/bin/bash

# Get all hardware ports and their interfaces

# sample output:
# <result>Belkin USB-C LAN (en8)
# Wi-Fi (en0)</result>
#
# modern JSS will print them on a single line, nothing to worry about

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
