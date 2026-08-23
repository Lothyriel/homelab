#!/usr/bin/env bash
set -euo pipefail

container_name="${1:-stoat-rabbit}"

for _ in $(seq 1 120); do
    if podman exec "$container_name" rabbitmq-diagnostics -q ping >/dev/null 2>&1; then
        exit 0
    fi

    sleep 1
done

echo "RabbitMQ is not ready in ${container_name}" >&2
exit 1
