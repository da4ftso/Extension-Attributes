#!/bin/bash

# macOS contains a built-in screen read^H^H^H^H Apache webserver that should be disabled in most cases.

status=$(/bin/launchctl list | /usr/bin/grep -c "org.apache.httpd")

if [[ $status = "0" ]]; then

	echo "<result>Disabled</result>"
    
else

	echo "<result>Enabled</result>"
    
fi
