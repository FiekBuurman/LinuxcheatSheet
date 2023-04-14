#! /bin/bash
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
apt autoremove && apt autoclean
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
source $HOME/.bashrc
# check this next time if it's auto loads the bashrc
cd ..
. ~/.bashrc
print_message "done" 
#### END SCRIPT ###