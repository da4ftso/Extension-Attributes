#!/bin/zsh

# this version returns both connected and disconnected devices.

# I am so sorry for this. please don't hurt me.

# old method, slow, heinous
# btdevices=$(system_profiler SPBluetoothDataType | grep -E 'Type:.*Headphones|Keyboard|Mouse' -C 4 | sed -e 's/0x004C/Apple/' -e 's/0x009E/Bose/' -e 's/0x04E8/Samsung/' -e 's/0x000A/JBL/' -e 's/0x054C/Sony/' -e 's/0x046D/Logi/' -e 's/0x0055/Platronics/' -e 's/0x0094/JLab/' | awk '!/Address|Product|Case|Firmware|Serial/' | tr -s ' ' | sed -E 's/Vendor ID:|Minor Type:|- Find My:| Battery Level|Transport: |Mouse Services:|Keyboard Services:|UART|HID|ACL|ANC|BLE|0x800020|0x1800019|0x800019|0x1980019|0x400000|GATT|HFP|AVRCP|A2DP|SCO|PCIe//g' | tr -d '\n')

# new hotness

btdevices=$(/usr/bin/wdutil info | awk '/Address/ { print prev } { prev = $0 }' | tail -n +6 | tr -s ' ' | sed '$d' | sed 's/‚Äô/'\''/g')

echo "<result>${btdevices}</result>"
