#!/bin/bash

# /usr/bin/app-sso is present in macOS Monterey and above

# reports status from devices logged in to AD via Kerberos SSO extension

# domain

domain=$(/usr/bin/app-sso -l -j | awk '/"/ { print $NF } ' | tr -d '",')

echo "<result>${domain}</result>"