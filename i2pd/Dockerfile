FROM alpine:latest AS builder
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"

RUN apk update && \
    apk add git cmake make gcc g++ zlib-dev openssl-dev boost-dev  && \
    git clone https://github.com/PurpleI2P/i2pd.git i2pd-src

RUN mkdir /i2pd && \
    cd /i2pd-src/build && \
    cmake -DCMAKE_INSTALL_PREFIX=/i2pd -DWITH_HARDENING=ON -DCMAKE_BUILD_TYPE=Release && \
    make && make install

FROM alpine:latest
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"
EXPOSE 4444

RUN apk update && \
    apk add boost openssl zlib curl && \
    addgroup -S i2pd && adduser -S i2pd -G i2pd && \
    mkdir -p /i2pd/ && chown -R i2pd:i2pd /i2pd /home/i2pd

USER i2pd
COPY --from=builder /i2pd /i2pd

ENTRYPOINT [ "/i2pd/bin/i2pd", "--conf", "/home/i2pd/i2pd.conf"]
