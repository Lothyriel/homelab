#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ -e .env || -e livekit.yml ]]; then
    echo "Refusing to overwrite .env or livekit.yml. Back them up and remove them to rotate secrets." >&2
    exit 1
fi

private_pem=$(mktemp)
trap 'rm -f "$private_pem"' EXIT
openssl ecparam -name prime256v1 -genkey -noout -out "$private_pem"

vapid_private=$(base64 -w 0 "$private_pem" | tr -d '=')
vapid_public=$(openssl ec -in "$private_pem" -outform DER 2>/dev/null | tail -c 65 | base64 -w 0 | tr '/+' '_-' | tr -d '=')
file_key=$(openssl rand -base64 32)
livekit_key=$(openssl rand -hex 6)
livekit_secret=$(openssl rand -hex 24)

umask 077
printf '%s\n' \
    "REVOLT__PUSHD__VAPID__PRIVATE_KEY=$vapid_private" \
    "REVOLT__PUSHD__VAPID__PUBLIC_KEY=$vapid_public" \
    "REVOLT__FILES__ENCRYPTION_KEY=$file_key" \
    "REVOLT__API__LIVEKIT__NODES__WORLDWIDE__KEY=$livekit_key" \
    "REVOLT__API__LIVEKIT__NODES__WORLDWIDE__SECRET=$livekit_secret" > .env

printf '%s\n' \
    'rtc:' \
    '  use_external_ip: true' \
    '  port_range_start: 50000' \
    '  port_range_end: 50100' \
    '  tcp_port: 7881' \
    'redis:' \
    '  address: 127.0.0.1:6379' \
    'turn:' \
    '  enabled: false' \
    'keys:' \
    "  $livekit_key: $livekit_secret" \
    'webhook:' \
    "  api_key: $livekit_key" \
    '  urls:' \
    '    - http://127.0.0.1:8500/worldwide' > livekit.yml

echo "Created .env and livekit.yml. Back up .env before starting Stoat."
