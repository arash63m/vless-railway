FROM alpine:latest

RUN apk add --no-cache --virtual .build-deps \
    git \
    make \
    cmake \
    libtool \
    automake \
    autoconf \
    g++ \
    linux-headers \
    && git clone https://github.com/XTLS/Xray-core.git \
    && cd Xray-core \
    && make \
    && mv ./main/xray /usr/local/bin/ \
    && cd .. \
    && rm -rf Xray-core \
    && apk del .build-deps

RUN apk add --no-cache ca-certificates

COPY config.json /etc/xray/config.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
