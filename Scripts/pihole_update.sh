#! /bin/bash
sudo date > ../home/scripts/pihole_update.log
echo "Start:" >> ../home/scripts/pihole_update.log

# update
sudo apt-get update && sudo apt-get upgrade -y ../home/scripts/pihole_update.log 2>&1

# remove
sudo apt-get autoremove && apt-get autoclean ../home/scripts/pihole_update.log 2>&1

# update pihole
/usr/local/bin/pihole -up ../home/scripts/pihole_update.log 2>&1
/usr/local/bin/pihole -g ../home/scripts/pihole_update.log 2>&1

# write to text
echo  "Last run" >> ../home/scripts/pihole_update.log
sudo date >> ../home/scripts/pihole_update.log
exit ../home/scripts/pihole_update.log 2>&1
