#!/bin/bash

app1="/Applications/TeradataStudio.app"
app2="/Applications/TeradataStudioExpress.app"

getBundleVersion() {
    local app="$1"
    local plist="${app}/Contents/Info.plist"

    if [[ ! -f "$plist" ]]; then
        # echo "Not Installed"
        return
    fi

    local version
    version=$(/usr/bin/defaults read "$plist" CFBundleVersion 2>/dev/null)

    if [[ -n "$version" ]]; then
        echo "$version"
    else
        echo "Unknown"
    fi
}

version1=$(getBundleVersion "$app1")
version2=$(getBundleVersion "$app2")

name1=$(/usr/bin/basename "$app1" .app)
name2=$(/usr/bin/basename "$app2" .app)

# echo "<result>${name1}: ${version1}; ${name2}: ${version2}</result>"
printf "<result>${name1}: ${version1}\n ${name2}: ${version2}</result>"

exit 0
