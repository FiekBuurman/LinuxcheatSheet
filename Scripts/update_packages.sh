#! /bin/bash
#touch ~/scripts/package_update.log
date >~/scripts/package_update.log
echo "Start:" >>~/scripts/package_update.log

# update
apt-get update >>~/scripts/package_update.log 2>&1
apt-get upgrade -y >>~/scripts/package_update.log 2>&1

# remove
apt-get autoremove >>~/scripts/package_update.log 2>&1
apt-get autoclean >>~/scripts/package_update.log 2>&1

# update pihole
/usr/local/bin/pihole -up >>~/scripts/package_update.log 2>&1
/usr/local/bin/pihole -g >>~/scripts/package_update.log 2>&1

# write to text
echo  "End Run..." >> ~/scripts/package_update.log
date >> ~/scripts/package_update.log
exit 
