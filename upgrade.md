# install Neo Fetch
```
rm /etc/update-motd.d/1-buurmansmotd
sudo apt-get install neofetch
sudo bash -c $'echo "neofetch" >> /etc/profile.d/mymotd.sh && chmod +x /etc/profile.d/mymotd.sh'
```
# update & clean packages
```
sudo apt update && apt upgrade -y && apt full-upgrade -y
sudo apt --purge autoremove
```
# reboot

# backup packages list
```
mkdir ~/apt
cp /etc/apt/sources.list ~/apt
cp -r /etc/apt/sources.list.d/ ~/apt
```
# replace version
```
sudo sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list
sudo sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list.d/*
```
# update repo
sudo apt update

sudo apt upgrade --without-new-pkgs -y

sudo apt full-upgrade

sudo reboot

sudo apt --purge autoremove
