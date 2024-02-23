#!/bin/bash

# EAs returning a data type of Date must be in (YYYY-MM-DD hh:mm:ss)
#
# but to get a Less Than we need to return a computed Integer

# returns mon day HH:mm:ss yyyy, ie Dec  9 20:55:33 2024 GMT

cert_exp_date=$(/usr/bin/security find-certificate -c "$(stat -f%Su /dev/console)" -p -Z "/Library/Keychains/System.keychain" | /usr/bin/openssl x509 -noout -enddate| cut -f2 -d=)


# if we wanted the Date, uncomment this
# 
# dateformat=$(/bin/date -j -f "%b %d %T %Y %Z" "$cert_exp_date" "+%Y-%m-%d %H:%M:%S")
# echo "<result>$dateformat</result>"


# instead let's convert that to epoch time, ie 1733799333

exp_date_epoch=$(date -j -f "%b %d %T %Y" "$cert_exp_date" '+%s' 2>/dev/null)


# check the time

currentDate=$(date +%s)


# shell arithmetic does not require declaring each var; https://www.shellcheck.net/wiki/SC2004

days=$(( (exp_date_epoch - currentDate)/86400 ))


# return a result

echo "<result>$days</result>"
