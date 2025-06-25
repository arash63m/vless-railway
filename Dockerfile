FROM alpine:latest

RUN apk add --no-cache curl unzip \
    && mkdir -p /usr/local/bin \
    && curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip \
    && unzip /tmp/xray.zip -d /tmp \
    && mv /tmp/xray /usr/local/bin/ \
    && rm -rf /tmp/xray.zip /tmp/*.json \
    && chmod +x /usr/local/bin/xray

COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
