#!/usr/bin/env bash
function notify() {
  local message="$1"
  echo -e "$message"
  ./discord.sh --webhook-url="$webhook_url" --username "$(hostname)" --text "$message"
}

notify "**__Starting [rsync on PhotoPrism] @ $(date)__**"

rsync --progress -r --delete --ignore-existing /home/buurmans/share/photoprism /home/buurmans/synology-app-backups

notify "**__Ended [rsync on PhotoPrism] @ $(date)__**"