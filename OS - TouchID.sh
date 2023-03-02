#!/bin/bash

# credit @mostlymac #jamfnation, no original source

### Checks to see if TouchID is enabled and returns the number of enrolled fingerprints per user if it is

touchidstatus=`sudo bioutil -s -c | sed 's/Operation performed successfully.//g'`

if [ "$touchidstatus" != "There are no fingerprints in the system." ]; then
	echo "<result>$touchidstatus</result>"
else
	echo "<result>Not configured</result>"
fi
