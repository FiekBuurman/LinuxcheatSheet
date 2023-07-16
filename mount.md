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

# file browser idea
- mount these dirs from proxmox, make sure the dirs exists inside of the container

``` pct set 204 -mp0 /mnt/pve/pve-share-smb-truenas,mp=/home/buurmans/shares/pve-smb-shared/```
``` pct set 204 -mp0 /mnt/pve/vaultshare,mp=/home/buurmans/shares/vaultshare/```
``` pct set 204 -mp0 /mnt/pve/usbdrive,mp=/home/buurmans/shares/usbdrive/```
``` pct set 204 -mp0 /mnt/pve/synology,mp=/home/buurmans/shares/synology/```

- map /home/buurmans/shares/ in your docker compose to acces all the shares

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
//192.168.2.231/pve-smb-shared /mnt/pve/pve-share-smb-truenas cifs credentials=/mnt/.smbcredentials,users,rw,iocharset=utf8
//192.168.2.231/vaultshare /mnt/pve/vaultshare cifs credentials=/mnt/.smbcredentials,users,rw,iocharset=utf8

```
 - mount the share:
 mount -a
mogelijk moet je even uit de dir gaan en opnieuw erin om het verschil te zien, soms zie je de bestanden op de share niet meteen.

Fix rights:
sudo chown -R nobody:nogroup /mnt/pve/vaultshare/
sudo chmod -R a+rwx /mnt/pve/vaultshare/