ln -s ~/homelab/timers ~/.config/systemd/user

ln -s ~/homelab/quadlets ~/.config/containers/systemd

sudo loginctl enable-linger $USER
