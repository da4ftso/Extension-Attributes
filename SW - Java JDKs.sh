#!/bin/bash

# 1.0.3 260501
#
# Prettyprint all Java VMs
#
# /usr/libexec/java_home --verbose will return something like:
#
# % /usr/libexec/java_home --verbose
# Matching Java Virtual Machines (4):
#    11.0.19 (arm64) "Amazon.com Inc." - "Amazon Corretto 11" /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
#    11.0.15 (x86_64) "Oracle Corporation" - "Java SE 11.0.15" /Library/Java/JavaVirtualMachines/jdk-11.0.15.jdk/Contents/Home
#    1.8.371.11 (x86_64) "Oracle Corporation" - "Java" /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
# /Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home

result=$(/usr/libexec/java_home --verbose 2>&1 |
  awk 'NR>1 { gsub(/[()"]/, ""); print $3, $1, $2 }')

if [[ "$result" =~ Please ]] ; then
	result="Not Found"
fi

printf "<result>$result</result>"
