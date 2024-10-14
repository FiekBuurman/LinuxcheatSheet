#!/bin/bash

# Variables
SCRIPTS_DIR="/home/buurmans/docker/scripts"
BACKUP_DIR="/home/buurmans/share/application_backups"
FILES=(
    "https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/refs/heads/main/Scripts/backupScripts/backup_cleanup.sh"
    "https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/refs/heads/main/Scripts/backupScripts/backup_docker_data.sh"
    "https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/refs/heads/main/Scripts/backupScripts/config.env"
    "https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/refs/heads/main/Scripts/backupScripts/discord.sh"
)

# Check if /home/buurmans/share/application_backup exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Directory $BACKUP_DIR does not exist."
    echo "Please mount the directory from the Proxmox host with the following command:"
    echo "Example: pct set 221 -mp0 /mnt/pve/buurmans-big-nas-share/,mp=/home/buurmans/share/"
    exit 1
fi

# Ensure required packages are installed
echo "Installing required packages: jq and rsync..."
apt update -y
apt install -y jq rsync

# Create the directory if it doesn't exist
mkdir -p "$SCRIPTS_DIR"

# Download each file into the scripts directory
echo "Downloading files to $SCRIPTS_DIR..."
for url in "${FILES[@]}"; do
    filename=$(basename "$url")
    curl -o "$SCRIPTS_DIR/$filename" "$url"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download $url"
        exit 1
    fi
done

# Make .sh files executable
echo "Setting executable permissions on .sh files..."
chmod +x "$SCRIPTS_DIR"/*.sh

# Prompt the user for WEBHOOK_URL and save it in config.env
read -p "Enter the WEBHOOK_URL: " WEBHOOK_URL
echo "WEBHOOK_URL=$WEBHOOK_URL" >> "$SCRIPTS_DIR/config.env"

# Prompt for cronjob time (hours and minutes)
read -p "At what hour should the backup run? (0-23): " HOUR
read -p "At what minute should the backup run? (0-59): " MINUTE

# Validate cron time input
if ! [[ "$HOUR" =~ ^[0-9]+$ ]] || [ "$HOUR" -lt 0 ] || [ "$HOUR" -gt 23 ]; then
    echo "Invalid hour: $HOUR"
    exit 1
fi

if ! [[ "$MINUTE" =~ ^[0-9]+$ ]] || [ "$MINUTE" -lt 0 ] || [ "$MINUTE" -gt 59 ]; then
    echo "Invalid minute: $MINUTE"
    exit 1
fi

# Create the cronjob
CRON_JOB="$MINUTE $HOUR * * * cd $SCRIPTS_DIR && /bin/bash backup_docker_data.sh"
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Setup complete! The backup scripts have been installed and scheduled to run at $HOUR:$MINUTE daily."
