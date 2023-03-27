#! /bin/bash
echo "Starting setup.sh"
source $HOME/.bashrc
/bin/rm -f setup.log
/bin/rm -r -f scripts
/bin/bash $HOME/.bashrc

echo "creating dir ../root/scripts"
mkdir ../root/scripts >>setup.log 2>&1
cd ../root/scripts >>setup.log 2>&1

echo "running updates"
apt update && apt ugrade -y >>setup.log 2>&1

echo "installing apps"
apt install -y bat >>setup.log 2>&1
apt install -y sudo >>setup.log 2>&1

echo "cleaning up"
apt autoremove && apt autoclean >>setup.log 2>&1

echo "getting .bash_aliases"
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_aliases >>setup.log 2>&1
echo ""
echo ""
echo "  Adding bash_aliases to bashrc"
echo "[[ -f ../root/scripts/.bash_aliases ]] && . ../root/scripts/.bash_aliases" >> $HOME/.bashrc
echo ""
sleep 2
source $HOME/.bashrc
# restart by source .bashrc or restart
# restart by . ~/.bash_aliases
echo "done...."
