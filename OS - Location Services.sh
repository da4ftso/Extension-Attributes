#!/usr/bin/env zsh

# not supported by macOS 27

LoggedinUser=$(/usr/bin/stat -f%Su /dev/console)
userGUID=$(dscl . -read "/Users/${LoggedinUser}" GeneratedUID | awk '{ print $2 }')

authStatus=$(defaults read /var/db/locationd/clients.plist $userGUID:icom.absolute.ctesservice.ase: | grep Authorized | awk -F ' = ' '{ print $2}')

if [[ ${authStatus} == "1;" ]]; then
	Result="Enabled by user"
elif [[ ${authStatus} == "0;" ]]; then
	Result="Disabled by user"
else
	Result="Not set"
fi

echo "<result>$Result</result>"
