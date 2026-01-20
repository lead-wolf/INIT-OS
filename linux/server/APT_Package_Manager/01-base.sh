#!/bin/bash
set -Eeuo pipefail

echo "=== Set Enviroment ==="
echo "PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'" > "/etc/environment"
source /etc/environment

echo "=== Base system ==="

apt update
apt upgrade -y

apt install -y \
  curl \
  vim \
  zip \
