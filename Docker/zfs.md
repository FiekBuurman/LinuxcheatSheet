If you wish to set a hard upper limit for ZFS ARC memory consumption, you can do some tuning with “/etc/modprobe.d/zfs.conf”

Edit 
 - nano /etc/modprobe.d/zfs.conf
which is likely empty or not created.
 - zfs_arc_min and zfs_arc_max
 - options zfs zfs_arc_min=1073741824
 - options zfs zfs_arc_max=4294967296 
 - update-initramfs -u
Reboot


# 1GiB
options zfs zfs_arc_min=1073741824
# 4GiB
options zfs zfs_arc_max=4294967296