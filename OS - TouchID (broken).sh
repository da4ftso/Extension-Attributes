#!/bin/bash
# Number of TouchID registered systemwide
# but only returns a numeric value;
# could be improved to check for touchID
#  ..and what about upgrades?

result=$(/usr/bin/bioutil -c -s | grep -v Operation)

echo "<result>$result</result>"
