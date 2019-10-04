#!/bin/bash

if [ "$HOST" ]; then
    AARGS="$AARGS --remote $HOST $PORT"
fi

# prepare up file
if [ "$USERNAME" -a "$PASSWORD" ]; then
    echo "$USERNAME" >> /up
    echo "$PASSWORD" >> /up
    AARGS="$AARGS --auth-user-pass /up"
fi

exec /usr/sbin/openvpn --config /etc/openvpn/*.conf --dev tun0 --script-security 2 --up /usr/local/bin/sockd.sh --down /usr/local/bin/sockd_down.sh $AARGS 
