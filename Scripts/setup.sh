echo "Starting setup.sh"
echo "running updates"
apt update && apt ugrade -y >>setup.log 2>&1
echo "installing apps"
apt install -y bat >>setup.log 2>&1
apt install -y sudo >>setup.log 2>&1
echo "cleaning up"
apt autoremove && apt autoclean >>setup.log 2>&1

echo "creating dir ../root/scripts"
mkdir ../root/scripts >>setup.log 2>&1
cd ../root/scripts >>setup.log 2>&1
echo "getting .bash_aliases"
#wget https://raw.githubusercontent.com/nallej/MyJourney/main/BashAddon.sh
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_aliases >>setup.log 2>&1
#echo "getting .bash_prompt"
#wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_prompt >>setup.log 2>&1
#/bin/bash /root/scripts/.bash_aliases
#/bin/bash /root/scripts/.bash_prompt

echo ""
echo ""
echo "  Adding bash_aliases to bashrc ofzo"
echo "[[ -f ../root/scripts/.bash_aliases ]] && . ../root/scripts/.bash_aliases" >> $HOME/.bashrc
echo ""
