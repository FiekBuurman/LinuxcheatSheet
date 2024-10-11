#!/bin/bash

# Load variables from .env file
set -a
source ./backup.env
set +a

DATE=$(date +"%Y%m%d%H%M%S")
BACKUP_FILENAME="plex_docker_data_backup_${DATE}.tar.gz"

function notify() {
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S')
    local message="$timestamp $1"
    echo -e "$message"
    ./discord.sh --webhook-url="$WEBHOOK_URL" --username "$(hostname)" --text "$message"
}

if [ ! -x "./discord.sh" ]; then
    notify "Error: discord.sh not found or not executable!"
    exit 1
fi

if [ ! -d "$BACKUP_SOURCE" ]; then
    notify "Error: Source directory $BACKUP_SOURCE does not exist!"
    exit 1
fi

if [ ! -d "$BACKUP_DEST" ]; then
    notify "Error: Destination directory $BACKUP_DEST does not exist!"
    exit 1
fi

notify "Starting backup of Docker data from $(hostname)..."

notify "Creating backup of $BACKUP_SOURCE..."
tar -czf "/tmp/$BACKUP_FILENAME" -C "$BACKUP_SOURCE" .

if [ $? -ne 0 ]; then
    notify "Error: Backup creation failed!"
    exit 1
fi

BACKUP_SIZE=$(du -h "/tmp/$BACKUP_FILENAME" | cut -f1)

notify "Moving backup ($BACKUP_SIZE) to $BACKUP_DEST..."
mv "/tmp/$BACKUP_FILENAME" "$BACKUP_DEST/"

if [ $? -ne 0 ]; then
    notify "Error: Failed to move backup to destination!"
    rm -f "/tmp/$BACKUP_FILENAME"
    exit 1
fi

notify "Backup completed successfully! \n - Backup file: $BACKUP_DEST/$BACKUP_FILENAME\n - Size: $BACKUP_SIZE"
