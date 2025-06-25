#!/bin/sh

set -e

# Generate UUID if not set
if [ -z "$UUID" ]; then
  export UUID=$(cat /proc/sys/kernel/random/uuid)
  echo "Generated UUID: $UUID"
fi

# Generate TLS cert
echo "Generating TLS certificates..."
openssl req -x509 -newkey rsa:4096 -keyout /etc/xray/key.pem -out /etc/xray/cert.pem -days 365 -nodes -subj "/CN=${DOMAIN:-localhost}"

# Create config.json
cat > /etc/xray/config.json <<EOF
{
  "inbounds": [
    {
      "port": ${PORT:-8080},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/cert.pem",
              "keyFile": "/etc/xray/key.pem"
            }
          ]
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

echo "Config file created:"
cat /etc/xray/config.json

# Run Xray
exec /usr/local/bin/xray -config /etc/xray/config.json
