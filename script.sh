#!/bin/bash

# set -e

# if [ "$(curl -s -o /dev/null -I -w "%{http_code}" icanhazip.com)" != "200" ] ; then exit 1; fi

# response=$(curl -s -o /dev/null -I -w "%{http_code}" icanhazip.com)

# case "$response" in
#         200) echo 200 ;;
#         301) echo 301 ;;
#         304) printf "Received: HTTP $response (file unchanged) ==> $url\n" ;;
#         404) printf "Received: HTTP $response (file not found) ==> $url\n" ;;
#           *) printf "Received: HTTP $response ==> $url\n" ;;
# esac

# if [ "$(curl -s icanhazip.com)" != $(sed -n '2p' ip.list) ]; then ./get.sh >/dev/null 2>&1 ; fi

# curl -s -o /dev/null -I -w "%{http_code}" icanhazip.com
# curl -I icanhazip.com 2>/dev/null | head -n 1 | cut -d$' ' -f2
# curl -so /dev/null -w '%{response_code}' icanhazip.com
