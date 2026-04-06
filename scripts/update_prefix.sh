ENV_FILE="$HOME/homelab/.env"
PREFIX=$("$HOME/homelab/scripts/ip_prefix.sh")

sed -i "s|^IPV6_PREFIX=.*|IPV6_PREFIX=$PREFIX|" "$ENV_FILE"

echo "Saved IPV6_PREFIX=$PREFIX to $ENV_FILE"

# reload coreDNS and caddy
systemctl --user daemon-reload && systemctl --user restart main-pod.service
