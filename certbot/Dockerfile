FROM alpine:latest AS builder
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"

WORKDIR /certbot
RUN apk update && \
    apk add --no-cache git python3 py3-pip && \
    git clone https://github.com/certbot/certbot src

RUN python -m venv venv && . ./venv/bin/activate && \
    python -m pip wheel src/acme src/certbot --wheel-dir=dist


FROM alpine:latest
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"

ENV EMAIL="" DOMAIN="" DRY_RUN=true

WORKDIR /certbot
COPY --from=builder /certbot/dist ./dist
COPY entrypoint.sh .
RUN apk update && apk add --no-cache python3 py3-pip && \
    python -m venv venv && . ./venv/bin/activate && python -m pip install dist/*whl && \ 
    addgroup -S certbot && adduser -S certbot -G certbot && chown -Rv certbot:certbot /certbot
USER certbot

ENTRYPOINT ["sh", "entrypoint.sh"]
