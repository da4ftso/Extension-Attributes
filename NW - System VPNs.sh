#!/bin/bash

# EA - NW - Check For VPN.sh

# call scutil to check for any existing system VPN configurations

# typically you can ignore 'ppp' entries - more interested in Nord, Proton, L2TP, etc

echo "<result>$(/usr/bin/scutil --nc list | sed '1d')</result>"
