#!/bin/bash

# let's query app-sso to get some fun and useful info

# domain

domain=$(/usr/bin/app-sso -l -j | awk '/"/ { print $NF } ' | tr -d '",')

# user_name (aka LAN ID)

user=$(/usr/bin/app-sso -i $domain -j | awk '/user_name/ { print $NF } ' | tr -d '",')

echo "<result>$user</result>"
