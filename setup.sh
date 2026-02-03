# systemd services setup

ln -sf ~/homelab/timers ~/.config/systemd/user

ln -sf ~/homelab/quadlets ~/.config/containers/systemd

sudo loginctl enable-linger $USER


# fail2ban setup
# we are copying here instead of symlinking because selinux won't let fail2ban follow the symlink in our home folder
sudo cp -r ~/homelab/fail2ban/* /etc/fail2ban/

echo "Setup complete"
