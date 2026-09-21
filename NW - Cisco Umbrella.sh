#!/bin/bash

# 1.0.1 check for Cisco Umbrella components
# regardless of Umbrella status (detected, running, extension loaded)

# revert to previous for a simple Installed / Not Installed

result="Not Installed"

if /usr/bin/systemextensionsctl list 2>/dev/null | \
   /usr/bin/grep -qiE 'com\.cisco\.anyconnect\.macos\.acsockext\b'
then
    result="Installed (Socket Extension)"
elif [ -d "/opt/cisco/secureclient/umbrella" ]
then
    result="Installed (Umbrella Directory)"
elif [ -f "/opt/cisco/secureclient/bin/UmbrellaDiagnostic.app" ]
then
    result="Installed (UmbrellaDiagnostic.app)"
fi

echo "<result>${result}</result>"
