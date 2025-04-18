FROM alpine:edge AS builder
LABEL org.opencontainers.image.authors="lans.rf@gmail.com"

WORKDIR /gitea-build
RUN apk add --no-cache git make nodejs npm go && \
    git clone https://github.com/go-gitea/gitea.git
ENV TAGS=bindata
RUN cd /gitea-build/gitea && make build

FROM alpine:latest
LABEL org.opencontainers.image.authors="lans.rf@gmail.com" 

WORKDIR /gitea
COPY --from=builder /gitea-build/gitea/gitea ./

RUN addgroup -S gitea && adduser -S gitea -G gitea && chown -Rv gitea:gitea /gitea && \
    apk add git bash

USER gitea
ENTRYPOINT ["./gitea", "web" ] 

