#!/bin/bash

# only run on Apple Silicon
arch=$(/usr/bin/arch)
if [ "$arch" != "arm64" ]; then
    echo "<result></result>"
    # echo "<result>N/A: Not an Apple Silicon Mac</result>"
    exit 0
fi

intel_apps=$(/usr/bin/find /Applications -name "*.app" -not -path "*Contents*" -exec sh -c '
  for app; do
    exe=$(defaults read "$app/Contents/Info" CFBundleExecutable 2>/dev/null)
    if [ -n "$exe" ] && [ -f "$app/Contents/MacOS/$exe" ]; then
      if ! /usr/bin/file "$app/Contents/MacOS/$exe" | /usr/bin/grep -q "arm64"; then
        echo "$app"
      fi
    fi
  done' _ {} + | /usr/bin/sed 's|^/Applications/||' | sort )

# Check if the string is empty
if [ -z "$intel_apps" ]; then
    echo "<result>None</result>"
else
    echo "<result>$intel_apps</result>"
fi
