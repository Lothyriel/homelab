#!/usr/bin/env bash
set -euo pipefail

label=${1:-guest}

if [[ ! $label =~ ^[A-Za-z0-9_-]+$ ]]; then
    echo "Label may contain only letters, numbers, underscores, and hyphens." >&2
    exit 2
fi

if ! podman container exists stoat-database; then
    echo "The stoat-database container is not running." >&2
    exit 1
fi

code="invite-${label}-$(openssl rand -hex 12)"

podman exec stoat-database mongosh --quiet revolt --eval \
    "db.account_invites.insertOne({_id: \"$code\"})" >/dev/null

echo "$code"
