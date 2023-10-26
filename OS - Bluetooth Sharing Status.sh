#!/bin/bash

# return current status of Bluetooth Sharing

# Bluetooth Sharing must have been previously enabled for this to return any value regardless of current status
# otherwise, a non-zero value will be returned: 
#
#   The domain/default pair of (com.apple.Bluetooth, PrefKeyServicesEnabled) does not exist


currentUser=$(stat -f%Su /dev/console)

state=$(sudo -u "$currentUser" defaults -currentHost read com.apple.Bluetooth PrefKeyServicesEnabled)

if [ $state = "1" ]; then
	status="Enabled"

elif [ $state = "0" ]; then
	status="Disabled"

fi    

echo "<result>$status</result>"

exit 0
