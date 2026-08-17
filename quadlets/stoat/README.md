# Stoat

Quadlet deployment for `https://chat.loty.click`, based on Stoat's official
self-hosted stack.

## Install

1. Run `./init.sh` once and back up the generated `.env` securely. Losing its
   file encryption key makes existing uploads inaccessible.
2. Copy or symlink this directory to
   `~/.config/containers/systemd/stoat`.
3. Run `systemctl --user daemon-reload` and
   `systemctl --user start stoat-pod.service`.
4. Reload the main Caddy service after deploying its updated Caddyfile.
5. Forward `7881/tcp` and `50000-50100/udp` through the host firewall and
   router for voice/video.

Registration is invite-only. Create an invite with:

```sh
./create-invite.sh alice
```

The optional argument is a label used to identify who the code is for. The
script generates a random suffix, inserts the code into `account_invites`, and
prints it. Without an argument it uses `guest`.

To manage invites manually, open MongoDB with:

```sh
podman exec -it stoat-database mongosh
```

Then run:

```javascript
use revolt
db.account_invites.insertOne({ _id: "choose-a-long-invite-code" })
```

The HTTP entry point is published on host port 8880 so the containerized main
Caddy can reach it through `host.containers.internal`. Block direct external
access to port 8880 in the host firewall; only Caddy should expose the service.
