#!/bin/sh

# Generate UUID if not set
if [ -z "$UUID" ]; then
  export UUID=$(cat /proc/sys/kernel/random/uuid)
fi

# Generate TLS cert if not exists
if [ ! -f "/etc/xray/cert.pem" ] || [ ! -f "/etc/xray/key.pem" ]; then
  openssl req -x509 -newkey rsa:4096 -keyout /etc/xray/key.pem -out /etc/xray/cert.pem -days 365 -nodes -subj "/CN=$DOMAIN"
fi

# Substitute environment variables in config
envsubst < /etc/xray/config.json.template > /etc/xray/config.json

# Run Xray
exec /usr/local/bin/xray -config /etc/xray/config.json
