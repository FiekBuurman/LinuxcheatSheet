#!/bin/bash
set -e

# Define the path variable
log_path=~/scripts/package_update.log

echo "Start:" > $log_path
date >> $log_path

# update
sudo apt-get update -q &>> $log_path
sudo apt-get upgrade -y -q &>> $log_path

# remove
sudo apt-get autoremove -q &>> $log_path
sudo apt-get autoclean -q &>> $log_path

# write to text
echo  "End Run..." >> $log_path
date >> $log_path

# exit with a zero status code
# indicating success
exit 0