# Mount usb to directory
find the drive:
 - lsblk

sdc is the drive
sdc1 is the partition you want to mount

locate the dir you want to mount
- mount /dev/sdc1 /mnt/pve/usbdrive

sdb                            8:16   0 119.2G  0 disk 
└─sdb1                         8:17   0 119.2G  0 part /mnt/pve/vm_and_ct_ssd
sdc                            8:32   0 931.5G  0 disk 
└─sdc1                         8:33   0 931.5G  0 part /mnt/pve/usbdrive


# fixing nas mounted drive
 - on promox make sure the drive is mounted:
``` mount -t nfs 192.168.2.253:/volume1/app_backups /mnt/app_backup ```
 - to mount the container aswell, run this on the proxmox host:
```pct set 202 -mp0 /mnt/app_backup,mp=/mnt/app_backup```
 - fix rights if needed: ```chmod 777 /mnt/app_backup```

# set mounts for containers, run it from the proxmox console
 pct set 216 -mp0 /mnt/pve/usbdrive/share,mp=/home/buurmans/share
 pct set 216 -mp1 /mnt/app_backup,mp=/home/buurmans/backups

# nfs mounting examples 
add nfs share to porxmox host:
 - mount -t nfs 192.168.2.231:/mnt/vault/share /mnt/pve/vault-share
add mount to container:
 - pct set 232 -mp0 /mnt/pve/vault-share,mp=/home/buurmans/vault-share

# un-mount
 - umount /mnt/pve/thingyToUnMount
don't forget to rm -rf /mnt/pve/thingyToUnMount to remove the dir too if you want.

# mount smb share
 - sudo apt-get install cifs-utils

make dir like: /mnt/pve/pve-share-smb-truenas

create a file for your credentials
  - /mnt/.smbcredentials
add:
 - username=yourUsername
 - password=yourPassword

add file so it's created on reboot
 - nano /etc/fstab

//[ip of server]/[name of share] /media/share cifs credentials=/root/.smb,users,rw,iocharset=utf8
```
//192.168.2.231/vaultshare /mnt/pve/test-pve-smb-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8

```
 - mount the share:
 mount -a
mogelijk moet je even uit de dir gaan en opnieuw erin om het verschil te zien, soms zie je de bestanden op de share niet meteen.


# Fix rights:
sudo chown -R nobody:nogroup /mnt/pve/vaultshare/
sudo chmod -R a+rwx /mnt/pve/vaultshare/

pct set 204 -mp0 /mnt/pve/pve-smb-shared,mp=/home/buurmans/shares/pve-smb-shared



De juiste manier:
maak een /etc/fstab op de proxmox host:

#lxd-share
//192.168.2.231/vaultshare /mnt/pve/test-pve-smb-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8

voeg hem toe ana de container:
pct set 204 -mp0 /mnt/pve/test-pve-smb-share,mp=/home/buurmans/shares/vaultshare/
en nu kan je hem gebruiken in een docker container....

# find mounts
findmnt

# delete mount 
umount /mnt/pve/test-pve-smb-share

# this ones need to be added to the proxmox host, make sure to create the /mnt/.smbcredentials and add it to /etc/fstab then run mount -a

//192.168.2.231/universe /mnt/pve/truenas-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8
//192.168.2.231/mnt/vault/universe /mnt/pve/truenas-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8

Deze is gebruikt op beide proxmox om de truenas te delen
//192.168.2.231/universe /mnt/pve/truenas-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000

//192.168.2.231/vaultshare /mnt/pve/vaultshare cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8
//192.168.2.231/pve-smb-shared /mnt/pve/pve-shared cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000,iocharset=utf8

# add mounted smb share to the container
pct set 204 -mp0 /mnt/pve/vaultshare,mp=/home/buurmans/shares/vaultshare/
pct set 204 -mp1 /mnt/pve/pve-shared,mp=/home/buurmans/shares/pve-smb-shared/

# on the new HP Server
//192.168.2.231/backups /mnt/pve/truenas-app-backups cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000
//192.168.2.231/share /mnt/pve/truenas-share cifs credentials=/mnt/.smbcredentials,uid=101000,gid=101000

 vault
    backups
    proxmox-backups    
    synology
    share
        media
        nextcloud
        etc etc