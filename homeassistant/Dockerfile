FROM python:3.13-alpine AS builder
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"

RUN apk update && \
    apk add git gcc g++ python3-dev musl-dev linux-headers && \
    mkdir -p /hass/dist/ && \
    git clone https://github.com/home-assistant/core /hass/core-src

RUN python -m venv /hass/venv && \
    . /hass/venv/bin/activate && \
    cd /hass/core-src && \
    python3 -m pip wheel . --wheel-dir=/hass/dist/

# Main
FROM python:3.13-alpine
LABEL Maintainer="lans.rf@gmail.com"

COPY --from=builder /hass/dist /hass/dist
RUN apk update --no-cache && \
    apk add --no-cache gcc g++ make python3-dev musl-dev linux-headers && \
    addgroup -S hass && adduser -S hass -G hass && \
    chown -R hass:hass /hass

USER hass
RUN python -m venv /hass/venv && . /hass/venv/bin/activate && \
    cd /hass/dist && python -m pip install *whl

ENTRYPOINT ["/hass/venv/bin/hass", "--config", "/config", "--log-file", "/config/log/hass/home-assistant.log", "--log-rotate-days", "1"]
