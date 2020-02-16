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

config_file=$(ls /etc/openvpn/*.conf)
if [ "$OPENVPN_CONF" ]; then
    config_file=/tmp/envvar.conf
    echo "$OPENVPN_CONF" > "$config_file"
fi

exec /usr/sbin/openvpn --config "$config_file" --dev tun0 --script-security 2 --up /usr/local/bin/sockd.sh --down /usr/local/bin/sockd_down.sh $AARGS 
