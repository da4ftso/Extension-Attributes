#!/bin/bash

# returns days since last launch instead of date string
# specify Data Type "Integer"

AppToCheck="/System/Applications/Mail.app"

if [ -d "${AppToCheck}" ]; then
        mailLaunchTime=$(mdls -name kMDItemLastUsedDate "${AppToCheck}" | cut -f 3 -d \ )
        validTime=$(echo "$mailLaunchTime" | grep "null" )
        if [ -z "$validTime" ]; then
                result="$mailLaunchTime"
        fi
fi

# convert to epoch and discard seconds

lastEpoch=$(date -jf "%Y-%m-%d" $mailLaunchTime +"%s" 2>/dev/null)

currentDate=$(date +%s)

# bash arithmetic

difference=$((currentDate - lastEpoch))

days=$((difference / 86400))

echo "<result>"$days"</result>"
