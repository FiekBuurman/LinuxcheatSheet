#!/bin/bash
#00 02 * * * cd /home/buurmans/docker/scripts && /bin/bash backup_docker_data.sh
set -a
source ./config.env
set +a

function notify() {
    local timestamp=$(date +'%Y-%m-%d %H:%M:%S')
    local message="[**$timestamp**]: $1"
    echo -e "$message"
    ./discord.sh --webhook-url="$WEBHOOK_URL" --username "$HOSTNAME" --text "$message"
}

notify "**__Start cleaning backups...__**"
BACKUP_FILES=($(ls -t $BACKUP_DEST/${HOSTNAME}_*.tar.gz))
FILE_COUNT=${#BACKUP_FILES[@]}
TOTAL_FREED_SPACE=0

if [ "$FILE_COUNT" -gt 5 ]; then

    DELETE_COUNT=$((FILE_COUNT - 5))
    notify "Found $DELETE_COUNT backups to delete"

    # Remove the oldest files (last in the sorted array)
    for ((i=5; i<FILE_COUNT; i++)); do
        FILE="${BACKUP_FILES[$i]}"
        FILE_SIZE=$(du -b "$FILE" | cut -f1)

        notify "Removing old backup: $FILE (Size: $(du -h "$FILE" | cut -f1))"

        # Uncomment the next line to actually remove the files
        rm -f "$FILE"
        
        TOTAL_FREED_SPACE=$((TOTAL_FREED_SPACE + FILE_SIZE))
    done

    FREED_SPACE_HUMAN=$(numfmt --to=iec --suffix=B $TOTAL_FREED_SPACE)
    notify "Total freed space: $FREED_SPACE_HUMAN"
else
    notify "No files to remove. Total backups: $FILE_COUNT"
fi

notify "**__Done cleaning backups...__**"
