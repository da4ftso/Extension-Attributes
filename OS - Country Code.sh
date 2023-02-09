#!/bin/bash

# curl ipinfo.io
# v1.1 220426 PWC
# v1.2 220523 PWC faster than awk'ing the country code
# v1.3 221005 PWC guess the site changed their request format

code=$(/usr/bin/curl -s ipinfo.io | awk '/country/ { print $2 }' | tr -d '",' )

echo "<result>$code</result>"

exit 0
