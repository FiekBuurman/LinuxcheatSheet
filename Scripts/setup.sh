apt update && apt ugrade -y
apt install -y bat


mkdir ../root/scripts
cd ../root/scripts
#wget https://raw.githubusercontent.com/nallej/MyJourney/main/BashAddon.sh
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_aliases
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_prompt
/bin/bash /root/scripts/.bash_aliases
/bin/bash /root/scripts/.bash_prompt



echo ""
echo ""
echo "  Adding bash_aliases to bashrc"
echo "[[ -f ../root/scripts/.bash_aliases ]] && . ../root/scripts/.bash_aliases" >> ../root/.bashrc
echo ""
