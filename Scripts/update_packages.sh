#! /bin/bash
#bash <(curl https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/update_packages.sh)
log_path = ~/scripts/package_update.log
echo "Start:" > $log_path
date >> $log_path

# update
apt-get update >> $log_path 2>&1
apt-get upgrade -y >> $log_path 2>&1

# remove
apt-get autoremove >> $log_path 2>&1
apt-get autoclean >> $log_path 2>&1

echo  "End Run..." >> $log_path
date >> $log_path
exit