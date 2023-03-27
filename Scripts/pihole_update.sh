#! /bin/bash
touch ../root/scripts/pihole_update.log
sudo date > ../root/scripts/pihole_update.log
echo "Start:" >> ../root/scripts/pihole_update.log

# update
sudo apt-get update && sudo apt-get upgrade -y ../root/scripts/pihole_update.log 2>&1

# remove
sudo apt-get autoremove && apt-get autoclean ../root/scripts/pihole_update.log 2>&1

# update pihole
/usr/local/bin/pihole -up ../root/scripts/pihole_update.log 2>&1
/usr/local/bin/pihole -g ../root/scripts/pihole_update.log 2>&1

# write to text
echo  "Last run" >> ../root/scripts/pihole_update.log
sudo date >> ../root/scripts/pihole_update.log
exit ../root/scripts/pihole_update.log 2>&1
