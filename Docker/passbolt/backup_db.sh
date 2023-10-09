#!/usr/bin/env bash

function notify() {
  local message="$1"
  local timestamp=$(date +'%Y-%m-%d %H:%M:%S')
  echo -e "$message"
  ./discord.sh --webhook-url="$webhook_url" --username "$(hostname)" --text "[**$timestamp**]: $message"
}

notify "**__Starting [Passbolt Backup Export] @ $(date)__**"

BACKUP_DIR=/home/buurmans/synology-app-backups
TEMP_DIR=$BACKUP_DIR/temp
PASSBOLT_CONTAINER_ID=$(docker ps -qf "name=passbolt-passbolt-1")
MYSQL_CONTAINER_ID=$(docker ps -qf "name=passbolt-db-1")
BACKUP_FILE=$BACKUP_DIR/passbolt_backup_$(date +'%Y%m%d%H%M%S').tar.gz

# Clean up previous backups
mkdir -p $TEMP_DIR

notify "Backing up serverkey_private.asc"
docker cp $PASSBOLT_CONTAINER_ID:/etc/passbolt/gpg/serverkey_private.asc $TEMP_DIR/serverkey_private.asc

notify "Backing up serverkey.asc"
docker cp $PASSBOLT_CONTAINER_ID:/etc/passbolt/gpg/serverkey.asc $TEMP_DIR/serverkey.asc

notify "Backing up database"
docker exec -i $MYSQL_CONTAINER_ID bash -c 'mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}' > $TEMP_DIR/backup.sql

notify "Creating backup tar in $BACKUP_DIR"
tar -czvf $BACKUP_FILE -C $TEMP_DIR .

notify "Created backup file $BACKUP_FILE"

# Clean up temporary directory
notify "Cleaning $TEMP_DIR"
rm -rf $TEMP_DIR

notify "**__Finished [Passbolt Backup Export] @ $(date)__**"

# pct set 212 -mp0 /mnt/pve/synology-app-backups/passbolt,mp=/home/buurmans/synology-app-backups