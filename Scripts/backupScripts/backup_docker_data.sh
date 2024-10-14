#!/bin/bash

set -a
source ./config.env
set +a

DATE=$(date +"%Y%m%d%H%M%S")
HOSTNAME=$(hostname)
BACKUP_FILENAME="${HOSTNAME}_docker_data_backup_${DATE}.tar.gz"
TEMP_DIR="/tmp/backup_sync"
BACKUPDESTINATION="{$BACKUP_DEST}/{$HOSTNAME}"

function notify() {
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S')
    local message="[**$timestamp**]: $1"
    echo -e "$message"
    ./discord.sh --webhook-url="$WEBHOOK_URL" --username "$HOSTNAME" --text "$message"
}

# Ensure the discord script exists and is executable
if [ ! -x "./discord.sh" ]; then
    notify "Error: discord.sh not found or not executable!"
    exit 1
fi

# Verify source directory exists
if [ ! -d "$BACKUP_SOURCE" ]; then
    notify "Error: Source directory $BACKUP_SOURCE does not exist!"
    exit 1
fi

# Ensure destination directory exists or create it
if [ ! -d "$BACKUPDESTINATION" ]; then
    mkdir -p "$BACKUPDESTINATION"
    if [ ! -d "$BACKUPDESTINATION" ]; then
        notify "Error: Destination directory $BACKUPDESTINATION could not be created!"
        exit 1
    fi
fi

# Prepare temporary sync directory
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi
mkdir -p "$TEMP_DIR"

# Rsync files to a temporary location to ensure consistency
notify "Syncing $BACKUP_SOURCE to temporary directory..."
rsync_output=$(rsync -a --delete "$BACKUP_SOURCE/" "$TEMP_DIR/" 2>&1)
if [ $? -ne 0 ]; then
    notify "Error: Rsync failed! Reason: $rsync_output"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Create the backup archive from the synced data
notify "Creating backup from synced data..."
tar_output=$(tar -czf "/tmp/$BACKUP_FILENAME" -C "$TEMP_DIR" . 2>&1)
if [ $? -ne 0 ]; then
    notify "Error: Backup creation failed! Reason: $tar_output"
    rm -rf "$TEMP_DIR"
    rm -f "/tmp/$BACKUP_FILENAME"
    exit 1
fi

# Cleanup temporary sync directory
rm -rf "$TEMP_DIR"

# Get backup size
BACKUP_SIZE=$(du -h "/tmp/$BACKUP_FILENAME" | cut -f1)

# Move the backup to the destination directory
notify "Moving backup to $BACKUPDESTINATION..."
mv_output=$(mv "/tmp/$BACKUP_FILENAME" "$BACKUPDESTINATION/" 2>&1)
if [ $? -ne 0 ]; then
    notify "Error: Failed to move backup! Reason: $mv_output"
    rm -f "/tmp/$BACKUP_FILENAME"
    exit 1
fi

# Notify success
notify "**__Backup completed successfully!__**"
notify "File: $BACKUPDESTINATION/$BACKUP_FILENAME ($BACKUP_SIZE)"
./backup_cleanup.sh
