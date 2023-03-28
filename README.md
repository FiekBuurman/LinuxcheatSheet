 # Set correct time zone
```
dpkg-reconfigure tzdata 
```
- Pick [Europe] - [Brussels]

# LinuxcheatSheet

- run after setup:
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

# Update Packages script for crontab
 - ``crontab -e``
 ``` 
 0 1 * * * /usr/bin/curl -s https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/update_packages.sh | /bin/bash 
 ```
