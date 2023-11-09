#!/bin/bash

# requires sudo when run interactively

taniumAgent="/Library/Tanium/TaniumClient/TaniumClient"

if [[ -e "${taniumAgent}" ]]; then
        version=$($taniumAgent --version)
        echo "<result>$version</result>"

else

        echo "<result>Not Installed</result>"

fi

exit 0
