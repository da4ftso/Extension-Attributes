#!/bin/bash

####################################################################################################
#
# Copyright (c) 2015, JAMF Software, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################
#
# SUPPORT FOR THIS PROGRAM
#
#       This program is distributed "as is" by JAMF Software.
#
####################################################################################################
#
# ABOUT THIS EXTENSION ATTRIBUTE
#
# NAME
# CurrentWifiNetworkEA.sh -- Reports currently selected Wifi interface
#
# RESULT TYPE
# String
#
# DESCRIPTION
# This extension attribute script was designed to report the currently selected Wifi interface 
# on an OS X computer.
#
# NOTES
# While the actual commands to parse and filter out the current Wifi interface from the results
# of using the networksetup command have not changed from the scripts previously posted on JAMF
# Nation, the versionCompare() function has been introduced to future-proof the comparison of OS X
# versions by doing an arithmetic comparison rather than a string comparison. This function should
# be re-usable in any bash scripts where this kind of comparison needs to be made.
# The determination of the Wi-Fi network has been updated to work correctly with OS X 10.7 and 
# above (up to 10.10 at the time of writing). 
#
####################################################################################################
#
# HISTORY
#
# Version: 1.1
#
# - Pete C. changed backticks to $(), removed support for older macOS (assume /usr/sbin/networksetup
#
# Version: 1.0.1
#
# - Created by Justin Sako on February 11, 2015
# - Optimization of OS X version comparison by Justin Sako on February 12, 2015
# 
####################################################################################################
#
# FUNCTIONS
#
####################################################################################################


function parameterMatchesRegexPattern ()
{
  local parameter="$1"
  local pattern="$2"

  if [[ "$parameter" =~ $pattern ]]; then
    return 0
  else
    return 1
  fi
}

function getCurrentWifiNetwork ()
{
  networksetupPath="/usr/sbin/networksetup"

  # Determine the current Wifi network

  if [ ! -f $networksetupPath ]; then
    local result="The networksetup binary is not present on this machine."
  else
    local device=$($networksetupPath -listallhardwareports | grep -A 1 Wi-Fi | awk '/Device/{ print $2 }')
    local result=$($networksetupPath -getairportnetwork "$device" | sed 's/Current Wi-Fi Network: //g')
  fi

  # Modify result to report shorter answers

  if [[ $(echo "$result" | grep "Error") != "" ]]; then
    result="No Wi-Fi Device Found"
  elif parameterMatchesRegexPattern "$result" "(.*)Wi-Fi[[:space:]]power[[:space:]]is[[:space:]]currently[[:space:]]off(.*)"; then
    result="Wi-Fi Off"
  elif parameterMatchesRegexPattern "$result" "^You[[:space:]]are[[:space:]]not[[:space:]]associated(.*)"; then
    result="Not Associated"
  fi

  echo "$result"
}


####################################################################################################
# MAIN
####################################################################################################

activeInterface=$(getCurrentWifiNetwork)

echo "<result>$activeInterface</result>"
