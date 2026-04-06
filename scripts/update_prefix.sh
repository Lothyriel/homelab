PREFIX=$("$HOME/homelab/scripts/ip_prefix.sh")

ENV_FILE="$HOME/.env"

echo "IPV6_PREFIX=$PREFIX" > "$ENV_FILE"

echo "Saved IPV6_PREFIX=$PREFIX to $ENV_FILE"
