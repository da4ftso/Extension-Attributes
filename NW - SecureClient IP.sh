#!/bin/bash

vpn="/opt/cisco/secureclient/bin/vpn"
result="Not Installed"

if [[ -x "$vpn" ]]; then
    if "$vpn" state 2>/dev/null | grep -q "state: Connected"; then
        result=$("$vpn" stats 2>/dev/null | awk '/Address \(IPv4\): / { print $NF; exit }')
        [[ -z "$result" ]] && result="Connected - No IPv4 Address"
    else
        result="Not Connected"
    fi
fi

echo "<result>$result</result>"
