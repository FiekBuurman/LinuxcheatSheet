#!/usr/bin/env bash

function notify() {
  local message="$1"
  echo -e "$message"
  ./discord.sh --webhook-url="$webhook_url" --username "$(hostname)" --text "$message"
}

notify "**__Starting [apt updates] @ $(date)__**"

excluded_containers=("$@")

function update_container() {
  container=$1
  name=$(/usr/sbin/pct exec "$container" hostname)
  os=$(/usr/sbin/pct config "$container" | awk '/^ostype/ {print $2}')
  case "$os" in
    ubuntu | debian | devuan)
    /usr/sbin/pct exec "$container" -- bash -c "apt-get update 2>/dev/null | grep 'packages.*upgraded'; apt list --upgradable && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -y" 
    notify " - updating: $container-$name"
    ;;     
  esac
}

for container in $(/usr/sbin/pct list | awk '{if(NR>1) print $1}'); do
  excluded=false
  for excluded_container in "${excluded_containers[@]}"; do
    if [ "$container" == "$excluded_container" ]; then
      excluded=true
      break
    fi
  done
  if [ "$excluded" == true ]; then
    notify "[Info] Skipping $container"
    sleep 1
  else
    status=$(/usr/sbin/pct status $container)
    template=$(/usr/sbin/pct config $container | grep -q "template:" && echo "true" || echo "false")
    if [ "$template" == "false" ] && [ "$status" == "status: stopped" ]; then
      notify "[Info] Starting $container"
      /usr/sbin/pct start $container
      notify "[Info] Waiting For $container To Start"
      sleep 5
      update_container $container
      notify "[Info] Shutting down $container"
      /usr/sbin/pct shutdown $container &
    elif [ "$status" == "status: running" ]; then
      update_container $container
    fi
  fi
done

wait
notify "Finished, All Containers Updated.\n"
