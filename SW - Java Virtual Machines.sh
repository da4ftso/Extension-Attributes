#!/bin/bash

# Prettyprint all Java VMs
#
# /usr/libexec/java_home --verbose will return something like:
#
# % /usr/libexec/java_home --verbose
# Matching Java Virtual Machines (4):
#    11.0.19 (arm64) "Amazon.com Inc." - "Amazon Corretto 11" /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
#    11.0.15 (x86_64) "Oracle Corporation" - "Java SE 11.0.15" /Library/Java/JavaVirtualMachines/jdk-11.0.15.jdk/Contents/Home
#    1.8.371.11 (x86_64) "Oracle Corporation" - "Java" /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
#    1.8.0_341 (x86_64) "Oracle Corporation" - "Java SE 8" /Library/Java/JavaVirtualMachines/jdk1.8.0_341.jdk/Contents/Home
# /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
#
# awk all the things

result=$(/usr/libexec/java_home --verbose 2>&1 | awk ' { print $3 " " $1 " " $2  } ' | sed '1d;$d' | tr -d '()"')

printf "<result>$result</result>"
