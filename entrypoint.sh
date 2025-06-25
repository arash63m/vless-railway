#!/bin/sh

set -e

# Create directory if not exists
mkdir -p /etc/xray

# Generate UUID if not set
if [ -z "$UUID" ]; then
  export UUID=$(cat /proc/sys/kernel/random/uuid)
  echo "Generated UUID: $UUID"
fi

# Generate TLS cert if not exists
if [ ! -f "/etc/xray/cert.pem" ] || [ ! -f "/etc/xray/key.pem" ]; then
  echo "Generating TLS certificates..."
  openssl req -x509 -newkey rsa:4096 -keyout /etc/xray/key.pem -out /etc/xray/cert.pem -days 365 -nodes -subj "/CN=${DOMAIN:-localhost}"
fi

# Substitute environment variables in config
if [ -f "/etc/xray/config.json.template" ]; then
  echo "Generating config.json from template..."
  envsubst < /etc/xray/config.json.template > /etc/xray/config.json
fi

# Run Xray
echo "Starting Xray..."
exec /usr/local/bin/xray -config /etc/xray/config.json
