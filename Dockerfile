FROM golang:1 AS builder
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
ENV XCADDY_SETCAP=0
RUN xcaddy build \
    --with github.com/tailscale/caddy-tailscale \
    --with github.com/caddy-dns/cloudflare \
    --output /usr/bin/caddy
FROM caddy:2.9.1
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
