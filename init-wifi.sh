#!/bin/sh

set +e

cat >/etc/NetworkManager/system-connections/wifi.nmconnection <<EOF
[connection]
id=wifi
uuid=95b17351-297c-4d9c-90f9-669d3ab81464
type=wifi

[wifi]
mode=infrastructure
ssid=${SSID}

[wifi-security]
key-mgmt=wpa-psk
psk=${PASSWORD}

[ipv4]
method=auto

[ipv6]
addr-gen-mode=default
method=auto

[proxy]
EOF
chmod 600 /etc/NetworkManager/system-connections/wifi.nmconnection

exit 0