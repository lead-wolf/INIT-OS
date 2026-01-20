#!/bin/bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/init.conf"

echo "Installing Nginx Proxy Manager with MySQL..."

# Create directory
mkdir -p "${APP_DIR}"
cd "${APP_DIR}"

# Create docker-compose.yml
cat > docker-compose.yml <<EOF
version: "3.8"

services:
  db:
    image: mariadb:10.11
    container_name: npm-mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: \${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: \${MYSQL_DATABASE}
      MYSQL_USER: \${MYSQL_USER}
      MYSQL_PASSWORD: \${MYSQL_PASSWORD}
    volumes:
      - ./mysql:/var/lib/mysql

  npm:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx-proxy-manager
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "80:80"
      - "81:81"
      - "443:443"
    environment:
      DB_MYSQL_USER: \${MYSQL_USER}
      DB_MYSQL_PASSWORD: \${MYSQL_PASSWORD}
      DB_MYSQL_NAME: \${MYSQL_DATABASE}
      TZ: \${TZ}
EOF

# Start with custom env file
docker compose --env-file "${SCRIPT_DIR}/init.conf" up -d

echo "Nginx Proxy Manager started!"

echo
echo "Nginx Proxy Manager started successfully!"
echo "Web UI: http://<SERVER_IP>:81"
echo
echo "Default login:"
echo "  Email: admin@example.com"
echo "  Password: changeme"
