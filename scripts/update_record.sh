#!/bin/sh
set -eu

# Load secret
. "$HOME/homelab/scripts/cloudflare/.env"

RECORD_ID="$1"
NAME="$2"

IPV6=$(ip -6 addr show scope global | awk '/64/ {print $2}' | cut -d/ -f1)
TS=$(date -Is)

curl -fsS \
  "https://api.cloudflare.com/client/v4/zones/5074610c453525d5514da0c7145a9b28/dns_records/$RECORD_ID" \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $CF_API_TOKEN" \
  -d "{
        \"name\": \"$NAME\",
        \"ttl\": 1,
        \"type\": \"AAAA\",
        \"comment\": \"updated by DDNS script at $TS\",
        \"content\": \"$IPV6\",
        \"proxied\": false
      }"
