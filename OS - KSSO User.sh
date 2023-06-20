#!/bin/bash

# /usr/bin/app-sso is present in macOS Monterey and above (as far back as Catalina or Big Sur?)

# reports status from devices logged in to AD via Kerberos SSO extension

# domain

domain=$(/usr/bin/app-sso -l -j | awk '/"/ { print $NF } ' | tr -d '",')

# user_name

user=$(/usr/bin/app-sso -i $domain -j | awk '/user_name/ { print $NF } ' | tr -d '",')

echo "<result>${user}</result>"
