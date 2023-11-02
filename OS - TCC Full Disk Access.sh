#!/bin/bash

# query the TCC.db to return all SystemPolicyAllFiles entitlements
#
# sample return:
#
# com.jamfsoftware.Composer
# com.apple.Terminal
# com.cisco.anyconnect.gui
# /Library/Application Support/NexthinkVersions/23.8.3.7_1/nxtupdater

results=$(/usr/bin/sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db 'select * from access' | awk -F'|' ' { print $2 } ')

echo "<result>$results</result>"
