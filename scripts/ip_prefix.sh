ip -6 a show dev enp1s0 scope global | awk '/inet6/ {print $2}' | cut -d: -f1-4 | sed 's/$/::\/64/' | head -n1
