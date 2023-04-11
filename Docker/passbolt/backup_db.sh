#!/bin/bash
set -e

print_message() {
    echo -e "\e[1m\e[44m\e[97m $1 \e[0m"
}

BACKUP_DIR=/home/passbolt_backups
PASSBOLT_CONTAINER_ID=$(docker ps -qf "name=passbolt-passbolt-1")
MYSQL__CONTAINER_ID=$(docker ps -qf "name=passbolt-db-1")

rm -rf $BACKUP_DIR
mkdir -p $BACKUP_DIR/temp

print_message "Backing up serverkey_private.asc"
docker cp $PASSBOLT_CONTAINER_ID:/etc/passbolt/gpg/serverkey_private.asc \
    $BACKUP_DIR/temp/serverkey_private.asc

print_message "Backing up serverkey.asc"
docker cp $PASSBOLT_CONTAINER_ID:/etc/passbolt/gpg/serverkey.asc \
    $BACKUP_DIR/temp/serverkey.asc

print_message "backing up database"
docker exec -i $MYSQL__CONTAINER_ID bash -c \
  'mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}' \
  > $BACKUP_DIR/temp/backup.sql

print_message "Creating backup tar in /mnt/app_backup"
tar -czvf /mnt/app_backup/passbolt_backup_$(date +'%Y%m%d%H%M%S').tar.gz \
    -C $BACKUP_DIR/temp .

print_message "Backup complete"


#print_message "Copying backup file to NFS share"
#scp $BACKUP_DIR/passbolt_backup_$(date +'%Y%m%d%H%M%S').tar.gz \
#    user@nfs-server:"$NFS_SHARE"

#sudo mount -t nfs 192.168.2.253:/volume1/app_backups /mnt/app_backup
#pct set 212 -mp0 /mnt/app_backup,mp=/mnt/app_backup
# on client sudo chmod 777 /mnt/app_backup