FROM alpine:latest AS builder
LABEL Maintainer="lans.rf@gmail.com"

RUN apk update && \
    apk add git automake autoconf gcc g++ libevent-dev openssl-dev zlib-dev make && \
    git clone https://gitlab.torproject.org/tpo/core/tor.git /tor-src

RUN mkdir /tor/ && \
    cd /tor-src && \
    ./autogen.sh && \
    ./configure --prefix=/tor/ --disable-manpage --disable-asciidoc --disable-html-manual && \
    make && make install

FROM alpine:latest
LABEL Maintainer="lans.rf@gmail.com"
EXPOSE 8888

COPY --from=builder /tor /tor
RUN apk update && \
    apk add libevent openssl zlib && \
    mkdir -p /tor/var/lib/tor && \
    addgroup -S tor && adduser -S tor -G tor && chown -Rv tor:tor /tor

USER tor
ENTRYPOINT [ "/tor/bin/tor", "-f", "/config/torrc" ]
