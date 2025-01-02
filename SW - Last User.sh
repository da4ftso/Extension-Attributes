#!/bin/bash

lastUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

echo "<result>$lastUser</result>"
