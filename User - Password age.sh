#!/bin/bash

# current password age

# needs some functionality to step through Users, probly dscl
USER=$(stat -f%Su /dev/console)

# return epoch time
passwordSet=$(/usr/bin/dscl . read /Users/$USER/ accountPolicyData | sed -n '/passwordLastSetTime/{n;s@.*<real>\(.*\)</real>@\1@p;}' | sed s/\.[0-9,]*$//g)

#current date in epoch
currentDate=$(date +%s)

# current date in epoch - password last changed in epoch
difference=$(/bin/expr $currentDate - $passwordSet)

echo "Password last changed: "$(/bin/expr $difference / 86400 | awk -F\. ' { print $1 } ') "days"
