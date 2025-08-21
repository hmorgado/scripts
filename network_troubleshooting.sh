#!/bin/bash

FQDN=$1

[ -z "$FQDN" ] && echo "Missing Fully Qualified Domain Name argument." && exit 1

check_dns_resolution () {
  echo
  host "$FQDN" > /dev/null && echo "Successfully resolved $FQDN"
}

check_reachability () {
  echo
  echo "pinging $FQDN"
  ping "$FQDN" -c 3 > /dev/null && echo "Successfully pinged $FQDN"
}

check_tcp () {
  echo
  nc -z "$FQDN" 443 && echo "Reached port 443 via TCP at $FQDN"
}

if [[ ! $(check_dns_resolution) ]]; then
  echo "DNS resolution failed, skipping TCP test"
  check_reachability
else
  check_tcp
fi

