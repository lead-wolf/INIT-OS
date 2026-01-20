#!/bin/bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/init.conf"

echo "Installing Wake-on-LAN service..."

cat > /etc/systemd/system/wol.service <<EOF
[Unit]
Description=Enable Wake-on-LAN
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ethtool -s ${IFACE} wol g
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable wol.service
systemctl start wol.service

echo "Wake-on-LAN installed successfully"
