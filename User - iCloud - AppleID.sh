#!/bin/bash

for user in $(ls /Users/ | grep -v Shared); do
    if [ -d "/Users/$user/Library/Application Support/iCloud/Accounts" ]; then
        Accts=$(find "/Users/$user/Library/Application Support/iCloud/Accounts" | grep '@' | awk -F'/' '{print $NF}')
        iCloudAccts+=(${user}: ${Accts})
    fi
done

echo "<result>$(printf '%s\n' "${iCloudAccts[@]}")</result>"
