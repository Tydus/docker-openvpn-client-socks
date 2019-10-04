# OpenVPN client + SOCKS proxy
# Usage:
# Create configuration (.ovpn), mount it in a volume
# docker run --volume=something.ovpn:/ovpn.conf:ro --device=/dev/net/tun --cap-add=NET_ADMIN
# Connect to (container):1080
# Note that the config must have embedded certs
# See `start` in same repo for more ideas

FROM alpine

COPY openvpn.sh sockd.sh sockd_down.sh healthcheck.sh /usr/local/bin/

RUN true \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update-cache dante-server openvpn bash openresolv openrc \
    && rm -rf /var/cache/apk/* \
    && chmod a+x /usr/local/bin/*.sh \
    && true

COPY sockd.conf /etc/

ENTRYPOINT [ "/usr/local/bin/openvpn.sh" ]

HEALTHCHECK CMD /usr/local/bin/healthcheck.sh
