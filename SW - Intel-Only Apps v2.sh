#!/bin/bash

# significantly faster
# addl sed to strip out /Applications - less accurate results in ~

# will return results including full path but skip contents of Library folders
# rm the grep -v from line 17 to get those as well (many mor e results possible)

# only run on Apple Silicon
arch=$(/usr/bin/arch)
if [ "$arch" != "arm64" ]; then
    echo "<result></result>"
    # echo "<result>N/A: Not an Apple Silicon Mac</result>"
    exit 0
fi

intel_apps=$(system_profiler SPApplicationsDataType | awk '/Kind: Intel/ { found=1 } found && /Location: / { sub(/.*Location: /, ""); print; found=0 }' | grep -v "/Library/" | sort )

# Check if the string is empty
if [ -z "$intel_apps" ]; then
    echo "<result></result>"
else
    intel_apps=$(echo "$intel_apps" | sed 's/\/Applications//g')
    echo "<result>$intel_apps</result>"
fi
