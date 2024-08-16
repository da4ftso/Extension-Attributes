#!/bin/bash

if [[ -e "/Applications/SketchUp 2024/SketchUp.app" ]]; then
        version="$(defaults read /Applications/SketchUp\ 2024/SketchUp.app/Contents/Info.plist CFBundleVersion)"
	echo "<result>$version</result>"
else
	echo "<result>Not Installed</result>"
fi

exit 0
