#!/bin/sh
set -eu

DIR="$HOME/.config/lg_renew"

for envfile in "$DIR"/*.env; do
    [ -f "$envfile" ] || continue

    # shellcheck disable=SC1090
    . "$envfile"

    if [ -z "${SESSION_TOKEN:-}" ]; then
        echo "Skipping $envfile (SESSION_TOKEN not set)"
        continue
    fi

    echo "Checking token from $(basename "$envfile")"

    curl -s -X GET \
      "https://developer.lge.com/secure/CheckDevModeSession.dev?sessionToken=${SESSION_TOKEN}"

    echo
done
