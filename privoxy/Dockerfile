FROM alpine:latest AS builder
LABEL Maintainer="lans.rf@gmail.com"

RUN apk update && \
    apk add git make automake autoconf gcc g++ zlib-dev pcre-dev brotli-dev && \
    git clone https://github.com/ssrlive/Privoxy /privoxy-src

RUN mkdir /privoxy && \
    cd /privoxy-src && \
    autoheader && autoconf && ./configure --with-brotli --prefix=/privoxy/ && \
    make && make install 

FROM alpine:latest
LABEL Maintainer="lans.rf@gmail.com"

COPY --from=builder /privoxy /privoxy
RUN apk update && \
    apk add zlib pcre brotli curl && \
    addgroup -S privoxy && adduser -S privoxy -G privoxy && \
    chown -R privoxy:privoxy /privoxy

USER privoxy

ENTRYPOINT [ "/privoxy/sbin/privoxy", "--no-daemon", "/config/privoxy.conf"]
