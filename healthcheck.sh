#!/bin/bash

# If the is start sequence is not finished yet, sockd do not exist.
pgrep sockd &>/dev/null || exit 1

# If the envvar HEALTHCHECK_IP is missing, assume we are healthy.
[ ! "$HEALTHCHECK_IP" ] && exit 0

# Check the IP and warn if it is not reachable.
ping "$HEALTHCHECK_IP" -c1 -W1 &>/dev/null || exit 1
