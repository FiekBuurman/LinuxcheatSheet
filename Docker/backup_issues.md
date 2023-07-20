
# get output to a file:

 - add: -o /var/log/rsync.log

rsync --stats -h -X -A --numeric-ids -aH --delete --no-whole-file --sparse --one-file-system --relative --exclude=/tmp/?* --exclude=/var/tmp/?* --exclude=/var/run/?*.pid --exclude=/home/buurmans/shares/vaultshare/ --exclude=/home/buurmans/shares/pve-smb-shared/ /proc/1823558/root//./ /tmp/vzdumptmp3516684_204/ -v

https://forum.proxmox.com/threads/lxc-container-backup-suspend-mode-exit-code-23.93497/

likely the tempdir is not set
-- tmpdir

rsync --stats -h -X -A --numeric-ids -aH --delete --no-whole-file --sparse --one-file-system --relative --exclude=/tmp/?* --exclude=/var/tmp/?* --exclude=/var/run/?*.pid --exclude=/home/buurmans/shares/vaultshare/ --exclude=/home/buurmans/shares/pve-smb-shared/ /proc/1823558/root//./ --tmpdir=/mnt/pve/vaultshare/temp/vzdumptmp3516684_204/ -v

tmpdir
/mnt/pve/vaultshare/temp


nano /etc/vzdump.conf 
