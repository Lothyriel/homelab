# ---------- Builder stage ----------
FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddy-dns/cloudflare

# ---------- Final stage ----------
FROM caddy:latest

# Copy the custom-built Caddy binary
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

EXPOSE 80 443
EXPOSE 53/udp
EXPOSE 53/tcp

# Default command
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
