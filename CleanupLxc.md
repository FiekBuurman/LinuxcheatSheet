https://itsfoss.com/free-up-space-ubuntu-linux/
apt-get clean  
docker system prune --all 
journalctl --disk-usage 
journalctl --vacuum-time=3d
