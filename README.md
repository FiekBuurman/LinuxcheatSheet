 # Set correct time zone
```
dpkg-reconfigure tzdata 
```
- Pick [Europe] - [Brussels]

# LinuxcheatSheet

- run after setup:
```
apt update && apt upgrade -y
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
