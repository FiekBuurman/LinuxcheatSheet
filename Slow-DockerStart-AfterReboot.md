
## Disable the ifupdown wait service that's failing
``systemctl disable ifupdown-wait-online.service && systemctl mask ifupdown-wait-online.service ```


# Stop the service if it's running
systemctl stop systemd-networkd-wait-online.service

# Disable it so it doesn't start at boot
systemctl disable systemd-networkd-wait-online.service

# Mask it to prevent any other service from starting it
systemctl mask systemd-networkd-wait-online.service

# Restart docker to apply the fix immediately
systemctl restart docker
