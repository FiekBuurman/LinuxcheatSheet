#!/bin/bash
print_message() {
    echo -e "\e[1m\e[44m\e[97m $1 \e[0m"
}
print_error() {
    echo -e "\e[1m\e[41m\e[97m $1 \e[0m"
}
pause() {
    local seconds=$1
    while [ $seconds -gt 0 ]; do
        echo -ne "\rSleeping for $seconds seconds...   "
        sleep 1
        : $((seconds--))
    done
    echo ""
}
update_container() {
    local id=$1
    print_message "Updating container $id..." 
    pct exec "$id" -- apt-get update || {
        print_error "Failed to update container $id"
        return 1
    }
    pct exec "$id" -- apt-get upgrade -y || { 
        print_error "Failed to upgrade container $id"
        return 1
    }
    return 0
}
update_vm() {
    local id=$1
    print_message "Updating VM $id..." 
    qm exec "$id" -- apt-get update || {
        print_error "Failed to update VM $id"
        return 1
    }
    qm exec "$id" -- apt-get upgrade -y || { 
        print_error "Failed to upgrade VM $id"
        return 1
    }
    return 0
}

print_message "Updating all containers and VMs..."
for id in $(pct list | awk '{if(NR>1) print $1}')
do
    if [ $(pct status $id | awk '{print $2}') == "running" ]
    then
        update_container "$id"
    else
        print_message "Starting container $id..."
        pct start $id
        pause 10
        update_container "$id" || {
            print_message "Stopping container $id..."
            pct stop $id
            continue
        }
        print_message "Stopping container $id..."
        pct stop $id
    fi
done

for id in $(qm list | awk '{if(NR>1) print $1}')
do
    if [ $(qm status $id | awk '{print $2}') == "running" ]
    then
        update_vm "$id"
    else
        print_message "Starting VM $id..."
        qm start $id
        pause 10
        update_vm "$id" || {
            print_message "Stopping VM $id..."
            qm stop $id
            continue
        }
        print_message "Stopping VM $id..."
        qm stop $id
    fi
done
print_message "All containers and VMs updated."