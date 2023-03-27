#! /bin/bash
#touch ~/scripts/pihole_update.log
date >~/scripts/pihole_update.log
echo "Start:" >>~/scripts/pihole_update.log

# update
apt-get update >>~/scripts/pihole_update.log 2>&1
apt-get upgrade -y >>~/scripts/pihole_update.log 2>&1

# remove
apt-get autoremove >>~/scripts/pihole_update.log 2>&1
apt-get autoclean >>~/scripts/pihole_update.log 2>&1

# update pihole
/usr/local/bin/pihole -up >>~/scripts/pihole_update.log 2>&1
/usr/local/bin/pihole -g >>~/scripts/pihole_update.log 2>&1

# write to text
echo  "End Run..." >> ~/scripts/pihole_update.log
date >> ~/scripts/pihole_update.log
exit 
