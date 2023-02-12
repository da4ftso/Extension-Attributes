#!/bin/bash

# query zerotier-cli, return version

# TO-DO: check if ZeroTier is running, return that status?

# check for binary, bail out

if [[ -e /usr/local/bin/zerotier-cli ]]; then

	version=$(/usr/local/bin/zerotier-cli info | awk ' { print $4 } ')
    
    echo "<result>$version</result>"
    
else

	echo "<result>CLI not found</result>"
    
fi
