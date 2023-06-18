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
