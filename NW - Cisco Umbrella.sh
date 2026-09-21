#!/bin/bash

# check for Cisco Umbrella components
# regardless of Umbrella status (detected, running, extension loaded)

if /usr/bin/systemextensionsctl list 2>/dev/null | \
    /usr/bin/grep -qiE 'com\.cisco\.anyconnect\.macos\.acsockext\b' || \
   [ -d "/opt/cisco/secureclient/umbrella" ] || \
   [ -f "/opt/cisco/secureclient/bin/UmbrellaDiagnostic.app" ]; then

    result="Installed"
else
    result="Not Installed"
fi

echo "<result>${result}</result>"

exit
