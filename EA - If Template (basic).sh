#!/bin/bash

# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html

if [ -f "/path/to/something" ] ; then # use -d for a directory
    echo "<result>Installed</result>"
else
    echo "<result>Not Installed</result>"
fi
