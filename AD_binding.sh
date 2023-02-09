#!/bin/bash

OSvers=$( sw_vers -productVersion | cut -d. -f2 )

## NOTE: Change "dc.domain.tld" to an internal master domain controller,
## or some other internal device for the ping command

if ping -c 2 -o dc.domain.tld; then
    ## Mac is on the network, continue
    if [[ $(dsconfigad -show | awk '/Active Directory Domain/{ print $NF }') == "dc.domain.tld" ]]; then
        ADCompName=$(dsconfigad -show | awk '/Computer Account/{ print $NF }')
        ## Mac has correct dsconfigad info, continue
#        if [[ "$OSvers" -ge "7"  ]]; then

            ## NOTE: Change the "DOMAIN" in the command below to your domain name

            security find-generic-password -l "/Active Directory/DOMAIN" | grep "Active Directory"
            if [ "$?" == "0" ]; then
                ## AD keychain file exists, continue
                ## NOTE: Change the "DOMAIN" in the command below to your domain name

                dscl "/Active Directory/DOMAIN/All Domains" read /Computers/"$ADCompName" | grep -i "$ADCompName"
                if [ "$?" == "0" ]; then
                    ## Successful lookup of computer record. AD communication is working
                    res="Yes"
                else
                    res="No - AD Lookup Failed"
                fi
            else
                res="No - AD Keychain Not Found"
            fi
#        else
#            if [[ "$OSvers" == "6" ]]; then
#                ## OS is 10.6.x, moving on to AD lookup
#                ## NOTE: Change the "DOMAIN" in the command below to your domain name
#
#                dscl "/Active Directory/ADHCSCINT/All Domains" read /Computers/"$ADCompName" | grep "$ADCompName"
#                if [ "$?" == "0" ]; then
#                    ## Successful lookup of computer record. AD communication is working
#                    res="Yes"
#                else
#                    res="No - AD Lookup Failed"
#                fi
#            fi
#        fi
    else
        ## NOTE: Change the "domain.comp.org" in the command below to your fqdn
        res="No - Not Joined to domain"
    fi
else
    ## Mac is not on the network or has no network connection
    echo "Not connected to company network"
    res="Remote"
fi

echo "<result>$res</result>"
