#!/usr/bin/env bash

#30 0 * * 3,7 /path/to/your/script.sh


function notify() {
  local message="$1"
  echo -e "$message"
  ./discord.sh --webhook-url="$webhook_url" --username "$(hostname)" --text "$message"
}

notify "**__Startin [Disc-Info] @ $(date)__**"

excluded_containers=("$@")

function get_disk_info() {
  local container=$1
  local disk_info=$(/usr/sbin/pct exec "$container" df /boot | awk 'NR==2{gsub("%","",$5); printf "%s %.1fG %.1fG %.1fG", $5, $3/1024/1024, $2/1024/1024, $4/1024/1024 }')
  echo "$disk_info"
}

function update_container() {
  local container=$1
  local name=$(/usr/sbin/pct exec "$container" hostname)
  local os=$(/usr/sbin/pct config "$container" | awk '/^ostype/ {print $2}')

  if [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
    local disk_info=$(get_disk_info "$container")
    read -ra disk_info_array <<<"$disk_info"
    local message="- [$container] : $name - Boot Disk: ${disk_info_array[0]}% full [${disk_info_array[1]}/${disk_info_array[2]} used, ${disk_info_array[3]} free]"
    notify "$message"
  else
    local message=" - [$container] : $name - [No disk info for ${os}]"
    notify "$message"
  fi
}

for container in $(/usr/sbin/pct list | awk '{if(NR>1) print $1}'); do
    status=$(/usr/sbin/pct status $container)
    template=$(/usr/sbin/pct config $container | grep -q "template:" && echo "true" || echo "false")

    if [ "$template" == "false" ] && [ "$status" == "status: stopped" ]; then
        echo -e "[Info] Starting $container"
        /usr/sbin/pct start $container
        echo -e "[Info] Waiting For $container To Start"
        sleep 5
        update_container $container
        echo -e "[Info] Shutting down $container"
        /usr/sbin/pct shutdown $container &
    elif [ "$status" == "status: running" ]; then
        update_container $container
    fi  
done
wait

notify "**__Finished [Disc-Info] @ $(date)__**"