#!/bin/bash

# query zerotier-cli, return version

# check for binary, bail out

if [[ -e /usr/local/bin/zerotier-cli ]]; then

	version=$(/usr/local/bin/zerotier-cli info | awk ' { print $4 } ')
    
    echo "<result>$version</result>"
    
else

	echo "<result>CLI not found</result>"
    
fi
