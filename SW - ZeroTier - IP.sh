#!/bin/bash

# query zerotier-cli, return internal IP
# check for binary, bail out
# to print IP /, change awk to: substr($NF, 1)}}' 

if [[ -e /usr/local/bin/zerotier-cli ]]; then

	IP=$(/usr/local/bin/zerotier-cli listnetworks | awk '{if (NR!=1) {print substr($NF, 1, length($NF)-3)}} ')
    
    echo "<result>$IP</result>"
    
else

	echo "<result>CLI not found</result>"
    
fi
