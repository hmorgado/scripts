#!/bin/bash

FQDN=$1

[ -z "$FQDN" ] && echo "Missing Fully Qualified Domain Name argument." && exit 1

check_dns_resolution () {
  echo
  host "$FQDN" &> /dev/null && \
  echo "Successfully resolved $FQDN" || \
  echo "Could not resolv $FQDN"
}

check_reachability () {
  echo
  echo "pinging $FQDN"
  ping "$FQDN" -c 3 &> /dev/null \
  && echo "Successfully pinged $FQDN" || \
  echo "Could not ping $FQDN"
}

check_tcp () {
  echo
  nc -z "$FQDN" 443 &> /dev/null && \
  echo "Reached port 443 via TCP at $FQDN" || \
  echo "Could not reach port 443 at $FQDN"
}

check_dns_resolution
check_reachability
check_tcp

