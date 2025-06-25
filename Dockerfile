FROM alpine:latest

# Install all required dependencies
RUN apk add --no-cache \
    curl \
    unzip \
    openssl \
    gettext

# Download and install Xray
RUN mkdir -p /usr/local/bin \
    && curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip \
    && unzip /tmp/xray.zip -d /tmp \
    && mv /tmp/xray /usr/local/bin/ \
    && rm -rf /tmp/xray.zip /tmp/*.json \
    && chmod +x /usr/local/bin/xray

# Create necessary directories
RUN mkdir -p /etc/xray

# Copy config files
COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh
COPY config.json.template /etc/xray/config.json.template

# Set permissions
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
