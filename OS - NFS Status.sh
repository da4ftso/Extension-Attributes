#!/bin/bash

# macOS conatins a built-in screen read^H^H^H^H^H^H NFS file server which should be disabled in most cases
#
# `nfsd status` will typically return:
#    nfsd service is enabled
#    nfsd is not running
# rather than parsing, let's just check launchctl

status=$(/bin/launchctl list | /usr/bin/grep "com.apple.nfsd" | awk ' { print $2 } ')

if [[ $status = "0" ]]; then

	echo "<result>Disabled</result>"
    
else

	echo "<result>Enabled</result>"
    
fi
