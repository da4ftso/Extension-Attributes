#!/bin/bash

# query zerotier-cli, return internal IP

# check for binary, bail out

if [[ -e /usr/local/bin/zerotier-cli ]]; then

	ip=$(/usr/local/bin/zerotier-cli listnetworks | awk '{if (NR!=1) {print substr($NF, 1, length($NF)-3)}} ')
    
    echo "<result>$ip</result>"
    
else

	echo "<result>CLI not found</result>"
    
fi
