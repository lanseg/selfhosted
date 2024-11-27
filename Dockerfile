FROM alpine:latest AS builder
LABEL Maintainer="lans.rf@gmail.com"

RUN apk update && \
    apk add git autoconf make gcc g++ pkgconf automake protobuf protobuf-c protobuf-c-dev gperf \
    nettle-dev gnutls-dev libev-dev oath-toolkit lz4-dev libseccomp-dev libnl3-dev readline-dev && \
    git clone https://gitlab.com/openconnect/ocserv /ocserv-src

RUN mkdir /ocserv-bin && \
    cd /ocserv-src && \
    autoreconf -fvi && \
    ./configure --prefix=/ocserv-bin/ &&  \
    make && make install 

FROM alpine:latest
LABEL Maintainer="lans.rf@gmail.com"

RUN apk update && \
    apk add llhttp protobuf oath-toolkit libev lz4 lz4-libs gnutls libnl3 protobuf-c libseccomp && \
    addgroup -S ocserv && adduser -S ocserv -G ocserv && \
    mkdir /ocserv/
COPY --from=builder /ocserv-bin /ocserv/dist

ENTRYPOINT [ \
  "/ocserv/dist/sbin/ocserv",  \
  "--foreground", \
  "--debug", "5", \
  "--pid-file", "/run/ocserv.pid", \
  "--config", "/ocserv/conf/ocserv.conf" ]

