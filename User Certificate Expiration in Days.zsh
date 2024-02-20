#!/bin/zsh

# EAs returning a data type of Date must be in (YYYY-MM-DD hh:mm:ss)
# but to get a Less Than we need to return a computed Integer

# returns mon day HH:mm:ss yyyy, ie Dec  9 20:55:33 2024 GMT
certexpdate=$(/usr/bin/security find-certificate -a -c "$(stat -f%Su /dev/console)" -p -Z "/Library/Keychains/System.keychain" | /usr/bin/openssl x509 -noout -enddate| cut -f2 -d=)

# instead let's convert that to epoch time, ie 1733799333
expdateepoch=$(date -j -f "%b %d %T %Y" $certexpdate '+%s' 2&>1 /dev/null)

# check the time
currentDate=$(date +%s)

# shell arithmetic
days=$(( ($expdateepoch - $currentDate)/86400 ))

# return a result
echo "<result>$days</result>"


