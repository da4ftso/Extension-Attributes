#!/bin/bash

# significantly faster than v1
# but how does SP track every installed app (installer, launch, etc)

# returns full path in /Apps and ~/Apps
# remove the grep from line 17 (caution, can return A LOT)

# only run on Apple Silicon
arch=$(/usr/bin/arch)
if [ "$arch" != "arm64" ]; then
    echo "<result></result>"
    # echo "<result>N/A: Not an Apple Silicon Mac</result>"
    exit 0
fi

intel_apps=$(system_profiler SPApplicationsDataType | awk '/Kind: Intel/ { found=1 } found && /Location: / { sub(/.*Location: /, ""); print; found=0 }' | grep -v "/Library/" | sort)

# Check if the string is empty
if [ -z "$intel_apps" ]; then
    echo "<result>None</result>"
else
    echo "<result>$intel_apps</result>"
fi
