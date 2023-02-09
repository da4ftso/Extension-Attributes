#!/bin/sh
userList=$(dscl . list /Users UniqueID | awk '$2 > 1000 {print $1}')
if [ "$userList" ]; then
   echo "<result>$userList</result>"
else
   echo "<result>No mobile users</result>"
fi
