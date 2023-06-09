#! /bin/bash

set -e

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

print_message() {
    echo -e "\e[1m\e[44m\e[97m $1 \e[0m"
}

print_message "Setting correct time zone" 
echo "tzdata tzdata/Areas select Europe" | debconf-set-selections
echo "tzdata tzdata/Zones/Europe select Brussels" | debconf-set-selections
rm -f /etc/localtime /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
print_message "done" 

print_message "Running updates" 
apt update && apt upgrade -y && apt dist-upgrade -y
print_message "done" 

print_message "Installing needed packages"
apt-get install ca-certificates curl gnupg bat sudo -y
print_message "done"

print_message "Some house cleaning" 
apt autoremove -y && apt autoclean -y
print_message "done" 

print_message "getting .bash_aliases" 

source $HOME/.bashrc
/bin/rm -r -f ../root/scripts
/bin/bash $HOME/.bashrc

mkdir ../root/scripts
cd ../root/scripts

wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_aliases
echo ""
echo ""
echo "  Adding bash_aliases to bashrc"
echo "[[ -f ../root/scripts/.bash_aliases ]] && . ../root/scripts/.bash_aliases" >> $HOME/.bashrc
echo ""
sleep 2
#source $HOME/.bashrc

echo -e "Welkom bij: \n             \e[34m░█▀▄░█░█░█░█░█▀▄░█▄█░▄▀▄░▄▀▄░▄▀▀\n             ░█▀▄░█░█░█░█░█▀▄░█░█░█▀█░█░█░▀▀█\n             ░▀▀░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀\e[0m" > /etc/motd

print_message "done" 

for i in {10..1}; do
    echo -ne "\e[1m\e[44m\e[97m System will reboot in $i seconds. Press Ctrl-C to cancel.\e[0m\r"
    sleep 1
done
echo -e "System will reboot now.\n"
shutdown -r now

#### END SCRIPT ###