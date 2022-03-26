#!/bin/bash

set -e

if $CREATE_NEW_CERT; then
    DOMAIN_STRING=""

    # backup field separator into variable
    Field_Separator=$IFS

    # set new field separator
    IFS=','

    # for each domain supplied, append it to the domain string
    for dn in $DOMAINS; do DOMAIN_STRING="$DOMAIN_STRING -d $dn"; done

    # remove leading whitespace
    DOMAIN_STRING=echo $DOMAIN_STRING | awk '{$1=$1};1'

    # restore field separator to original
    IFS=$Field_Separator

    # create the new cert
    certbot certonly --key-type ecdsa --cert-name $CERTNAME --dns-cloudflare --dns-cloudflare-credentials $CLOUDFLARE_API_TOKEN $DOMAIN_STRING --email $EMAIL --agree-tos
fi

## Calculate seconds to sleep
SLEEP_SECONDS=$(( $DAYS * 86400))

## Loop indefinitely, checking if renewal is required at set interval, $DAYS
while true; do
    certbot renew --key-type ecdsa --cert-name $CERTNAME 
    echo "Sleeping for $SLEEP_SECONDS"
    sleep $SLEEP_SECONDS
done
