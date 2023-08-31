
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
 - qm set 231 -scsi4 /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K6AC33J5
 - qm set 231 -scsi5 /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K5NPL12H

you want to create something like:

check the config file: in /etc/pve/qemu-server and add the serial:

sdb                                 8:16   0   3.6T  0 disk   /dev/disk/by-id/wwn-0x5000c5008ff0bba7 /dev/disk/by-id/ata-ST4000DM000-1F2168_W30128HC
sdc                                 8:32   0   3.6T  0 disk   /dev/disk/by-id/wwn-0x5000c500b4a37362 /dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3XFYC
sdd                                 8:48   0   3.6T  0 disk   /dev/disk/by-id/ata-ST4000DM000-1F2168_W3012796 /dev/disk/by-id/wwn-0x5000c5008ff1a764
sde                                 8:64   0   3.6T  0 disk   /dev/disk/by-id/wwn-0x50014ee20f718d09 /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K6AC33J5
sdf                                 8:80   0   3.6T  0 disk   /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K5NPL12H /dev/disk/by-id/wwn-0x50014ee2648d5cbd

scsi0: NVME:vm-231-disk-0,size=10G
scsi1: /dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3XFYC,size=3907018584K,serial=ZGY3XFYC,backup=0
scsi2: /dev/disk/by-id/ata-ST4000DM000-1F2168_W30128HC,size=3907018584K,serial=W30128HC,backup=0
scsi3: /dev/disk/by-id/ata-ST4000DM000-1F2168_W3012796,size=3907018584K,serial=W3012796,backup=0
scsi4: /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K6AC33J5,size=3907018584K,serial=WD-WCC7K6AC33J5,backup=0
scsi5: /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K5NPL12H,size=3907018584K,serial=WD-WCC7K5NPL12H,backup=0


| Machine  | Model                      | Serial               | Vendor                  | Info                  |
|----------|----------------------------|----------------------|-------------------------|-----------------------|
| Lenovo   | WDC_WD40EFRX-68N32N0       | WD-WCC7K5NPL12H      | Plofkotje - Tweakers    | WDRED 4TB HDD         |
| Lenovo   | WDC_WD40EFRX-68N32N0       | WD-WCC7K6AC33J5      | Chamu - Tweakers        | WDRED 4TB HDD         |
| Lenovo   | INTENSO_SATA_III_SSD       | 1169079102A900043742 | Erol - Tweakers         | Intenso 240GB SSD     |
| proxmoxS | TK0080GDSAE                | PHWL4495024C080KGN   | quadrofource - Tweakers | ?? 80 GB SSD          |
| proxmoxS | Samsung_SSD_850_PRO_128GB  | S24ZNSAG401164E      | MOS                     | Samsung 128GB SSD     |
| proxmoxL | Micron_2400_MTFDKBA512QFM  | 22423BF4B4B3         | Stef                    | 512GB NVME            |
| proxmoxL | Samsung_SSD_840_PRO_Series | S1ANNSADC41514N      | MOS                     | 128GB SSD             |
| proxmoxL | KINGSTON_SA400S37120G      | 50026B7675000D96     | Jafar                   | 120GB SSD             |
| proxmoxL | ST4000VN008-2DR166         | ZGY3XFYC             | MOS                     | Seagate Iron Wolf 4TB |
| proxmoxL | ST4000DM000-1F2168         | W30128HC             | MOS                     | Seagate Desktop 4TB   |
| proxmoxL | ST4000DM000-1F2168         | W3012796             | MOS                     | Seagate Desktop 4TB   |
