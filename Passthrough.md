
Get the disks:

``` lsblk |awk 'NR==1{print $0" DEVICE-ID(S)"}NR>1{dev=$1;printf $0" ";system("find /dev/disk/by-id -lname \"*"dev"\" -printf \" %p\"");print "";}'|grep -v -E 'part|lvm' ```

example output:
NAME                         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT DEVICE-ID(S)
sda                            8:0    0   3.6T  0 disk   /dev/disk/by-id/wwn-0x5000c500b4a37362 /dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3XFYC
sdb                            8:16   0 119.2G  0 disk   /dev/disk/by-id/wwn-0x50025385a01870b4 /dev/disk/by-id/ata-Samsung_SSD_840_PRO_Series_S1ANNSADC41514N
sdc                            8:32   0   3.6T  0 disk   /dev/disk/by-id/ata-ST4000DM000-1F2168_W30128HC /dev/disk/by-id/wwn-0x5000c5008ff0bba7
sdd                            8:48   0   3.6T  0 disk   /dev/disk/by-id/wwn-0x5000c5008ff1a764 /dev/disk/by-id/ata-ST4000DM000-1F2168_W3012796
sde                            8:64   1 111.8G  0 disk   /dev/disk/by-id/wwn-0x5000000000000000 /dev/disk/by-id/ata-KINGSTON_SA400S37120G_50026B7675000D96

check how what number of scsi are in use, if there is only 1 drive (default) scsi0 is used, so next up is scsi1.

 - qm set 231 -scsi1 /dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3XFYC
 - qm set 231 -scsi2 /dev/disk/by-id/ata-ST4000DM000-1F2168_W30128HC
 - qm set 231 -scsi3 /dev/disk/by-id/ata-ST4000DM000-1F2168_W3012796
 - qm set 231 -scsi4 /dev/disk/by-id/ata-WDC_WD10SMZW-11Y0TS0_WD-WXN1A8710Z83

you want to create something like:

check the config file: in /etc/pve/qemu-server and add the serial:

/dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3XFYC,size=3726GiB,serial=ZGY3XFYC
/dev/disk/by-id/ata-ST4000DM000-1F2168_W30128HC,size=3726GiB,serial=W30128HC
/dev/disk/by-id/ata-ST4000DM000-1F2168_W3012796,size=3726GiB,serial=W3012796
/dev/disk/by-id/ata-WDC_WD10SMZW-11Y0TS0_WD-WXN1A8710Z83,backup=0,size=953837M


| Machine | Model | Serial | Vendor|
| Lenovo | WDC_WD40EFRX-68N32N0 | WD-WCC7K5NPL12H | Plofkotje on Tweakers |
