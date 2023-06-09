 # Set correct time zone
```
dpkg-reconfigure tzdata 
```
- Pick [Europe] - [Brussels]

```
echo "tzdata tzdata/Areas select Europe" | debconf-set-selections
echo "tzdata tzdata/Zones/Europe select Brussels" | debconf-set-selections
rm -f /etc/localtime /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
```

# LinuxcheatSheet

- run after setup:
```
apt update && apt upgrade -y && apt dist-upgrade -y
```
```
apt install curl -y 
bash <(curl https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/setupV2.sh)
```
```
bash <(curl https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/setup.sh)
```
 - run ``. ~/.bashrc``
 - and `` reboot now ``

# Pi-hole update script for crontab
 - ``crontab -e``
``` 
15 0 * * * /usr/bin/curl -s https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/pihole_update.sh | /bin/bash 
```
Check logs via: ``cat /root/scripts/pihole_update.log``
Check mail via: ``cat var/mail/root``

# Update Packages script for crontab
 - ``crontab -e``
``` 
0 1 * * * /usr/bin/curl -s https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/update_packages.sh | /bin/bash 
```
if crontab not using nano: 
```
export VISUAL=nano; crontab -e
```

# Install Docker + Compose
```
bash <(curl https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Docker/auto_setup_docker_debian.sh)
```

 - container configs:  /etc/pve/lxc
 - VM configs:         /etc/pve/qemu-server
 - CT and VM drives    /mnt/pve/vm_and_ct_ssd

# fix ssh into containers
```
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/rootlogin.conf && systemctl restart sshd.service
```

# login / motd
# https://www.putorius.net/custom-motd-login-screen-linux.html
```
sudo apt-get install neofetch
sudo bash -c $'echo "neofetch" >> /etc/profile.d/mymotd.sh && chmod +x /etc/profile.d/mymotd.sh'
```