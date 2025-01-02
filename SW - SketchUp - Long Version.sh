#!/bin/bash

# Jamf inventory will report the short version:
# SketchUp.app	24.0
#
# for patch control we need the long version:
# 24.0.598
#
# this EA checks for the most recent version of the app so we know what to patch

if [[ -e "/Applications/SketchUp 2024/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2024/SketchUp.app/Contents/Info.plist"

elif [[ -e "/Applications/SketchUp 2023/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2023/SketchUp.app/Contents/Info.plist"

elif [[ -e "/Applications/SketchUp 2022/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2022/SketchUp.app/Contents/Info.plist"

elif [[ -e "/Applications/SketchUp 2021/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2021/SketchUp.app/Contents/Info.plist"

elif [[ -e "/Applications/SketchUp 2020/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2020/SketchUp.app/Contents/Info.plist"

elif [[ -e "/Applications/SketchUp 2018/SketchUp.app" ]]; then
	app="/Applications/SketchUp 2018/SketchUp.app/Contents/Info.plist"
fi


version=$(defaults read "${app}" CFBundleVersion)

echo "<result>$version</result>"

exit 0
