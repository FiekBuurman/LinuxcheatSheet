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