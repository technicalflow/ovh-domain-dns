#!/bin/bash

set -e

if [ "$(curl -s -o /dev/null -I -w "%{http_code}" icanhazip.com)" != "200" ] ; then exit 1; fi

OVH_CONSUMER_KEY="..."
OVH_APP_KEY="..."
OVH_APP_SECRET="..."

DOMAIN="example.com"

function1 ()
{
    TIME=$(curl -s https://api.ovh.com/1.0/auth/time)

    # GET
    HTTP_METHOD="GET"
    HTTP_QUERY="https://eu.api.ovh.com/v1/domain/zone/$DOMAIN/record?fieldType=A"
    HTTP_BODY=""

    CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
    SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')

    X=$(curl -s -X $HTTP_METHOD -H "Content-Type:application/json"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY | grep -E -o '[0-9]+')
    # echo -n $X

    IP=$(curl -s icanhazip.com)

    # PUT
    HTTP_METHOD="PUT"
    HTTP_QUERY="https://eu.api.ovh.com/v1/domain/zone/$DOMAIN/record/"$X
    HTTP_BODY='{"target": "'$IP'","ttl":60}'

    #TIME=$(curl -s https://api.ovh.com/1.0/auth/time)

    CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
    SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')

    curl -X $HTTP_METHOD -H "Content-Type:application/json"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY

    # POST
    HTTP_METHOD="POST"
    HTTP_QUERY="https://eu.api.ovh.com/v1/domain/zone/$DOMAIN/refresh"
    HTTP_BODY=''

    #TIME=$(curl -s https://api.ovh.com/1.0/auth/time)

    CLEAR_SIGN="$OVH_APP_SECRET+$OVH_CONSUMER_KEY+$HTTP_METHOD+$HTTP_QUERY+$HTTP_BODY+$TIME"
    SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 | sed -e 's/^.* //')

    curl -X $HTTP_METHOD -H "Content-Type:application/json"  -H "X-Ovh-Application:$OVH_APP_KEY" -H "X-Ovh-Timestamp:$TIME" -H "X-Ovh-Signature:$SIG" -H "X-Ovh-Consumer:$OVH_CONSUMER_KEY" --data "$HTTP_BODY" $HTTP_QUERY
    
    #Works on Linux - not on mac ('brew install gnu-sed' for mac and change sed into gsed)
    sed -i "/IPs/a$(echo $IP)\n$(date)" ip.list
    
    #echo $IP >> ip.list
    #sed -i "/IPs/a$(echo $IP)\ " ip.list
}

if [ "$(curl -s icanhazip.com)" != $(sed -n '2p' ip.list) ]; then function1 >/dev/null 2>&1 ; fi
