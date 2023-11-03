#!/bin/bash

# query the TCC.db to return all SystemPolicyAllFiles entitlements
#
# sample return:
#
#  com.jamfsoftware.Composer
#  com.cisco.anyconnect.gui
#  NexthinkVersions/23.8.3.7_1/nxtupdater
#
# when using interactively in the shell: printf "%s\n" $results

results=$(/usr/bin/sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db 'select * from access' | awk -F'|' ' { print $2 } ' | grep -Ev "com.apple|System" | sed 's/\/Library\/Application Support\///g' )

echo "<result>$results</result>"
