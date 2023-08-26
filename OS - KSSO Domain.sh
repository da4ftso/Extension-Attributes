#!/bin/bash

# /usr/bin/app-sso is present in macOS Monterey and above (as far back as Catalina or Big Sur?)
# but on Monterey, output seems to be different -
# try parsing the .plist instead:
# defaults read /Users/$loggedInUser/Library/Group\ Containers/group.com.apple.KerberosExtension/Library/Preferences/group.com.apple.KerberosExtension.plist DOMAIN.TLD:userName

# reports status from devices logged in to AD via Kerberos SSO extension

# domain=$(/usr/bin/app-sso -l -j | awk '/"/ { print $NF } ' | tr -d '",')

domain=$(/usr/bin/app-sso -l -j | awk '/"/ { print substr($1, 2, length($1) - 2) }')

echo "<result>${domain}</result>"
