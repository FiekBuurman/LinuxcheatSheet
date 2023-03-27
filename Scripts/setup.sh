apt update && apt ugrade -y
apt install -y bat

cd ../root
mkdir ../root/scripts
#wget https://raw.githubusercontent.com/nallej/MyJourney/main/BashAddon.sh
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_aliases
wget https://raw.githubusercontent.com/FiekBuurman/LinuxcheatSheet/main/Scripts/.bash_prompt
. .bash_aliases
. .bash_
