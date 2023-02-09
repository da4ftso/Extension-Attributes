#!/bin/sh

# EA to pull specific printer driver version
# https://www.jamf.com/jamf-nation/discussions/10384/extension-attribute-for-printer-driver-version

# globals

ppdDir=$(/etc/cups/ppd)
printerName="YourPrinter" # no need to use a parameter here

# grab the driver version

driverVer=$(cat $ppdDir/$printerName.ppd | awk '/FileVersion/{ gsub(/"/,""); print $2 })

echo "<result>$driverVer</result>"
