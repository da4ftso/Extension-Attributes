#!/bin/sh

result=$(/usr/sbin/ioreg -r -c "AppleSmartBattery" | awk '/PermanentFailureStatus/ { print $3 } ')

if [ "$result" == "1" ]; then
result="Failure"
elif [ "$result" == "0" ]; then
result="OK"
fi

echo "<result>$result</result>"
