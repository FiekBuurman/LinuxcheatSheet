https://forum.proxmox.com/threads/proxmox-ve-6-removing-cluster-configuration.56259/
systemctl stop pve-cluster corosync
pmxcfs -l
rm /etc/corosync/*
rm /etc/pve/corosync.conf
killall pmxcfs
systemctl start pve-cluster