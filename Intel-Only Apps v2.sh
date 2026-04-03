#!/bin/bash

# significantly faster
# but how does SP register every app? does it require being launched at least once?

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
    echo "<result>None</result>"
else
    echo "<result>$intel_apps</result>"
fi
