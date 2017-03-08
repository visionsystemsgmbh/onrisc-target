#!/bin/sh

# mount boot partition
mount /dev/mmcblk0p1 /mnt
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to mount boot partition
        exit 1
fi

# MLO
cat /mnt/MLO > /dev/mtdblock0
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to burn MLO
        exit 1
fi

# barebox
cat /mnt/barebox.bin > /dev/mtdblock4
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to burn barebox.bin
       exit 1
fi

ubidetach -p /dev/mtd5

# format and attach an UBI partition
ubiformat -y /dev/mtd5
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to format /dev/mtd5
        exit 1
fi

ubiattach -p /dev/mtd5
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to attach /dev/mtd5
        exit 1
fi

ubimkvol /dev/ubi0 -N rootfs -s 56MiB
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to create kernel partition
        exit 1
fi

ubiblock --create /dev/ubi0_0
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to create rootfs block
        exit 1
fi

ubiupdatevol -t /dev/ubi0_0

ubiupdatevol /dev/ubi0_0 /mnt/openwrt-baltos-squashfs.img
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to create rootfs squashfs partition
        exit 1
fi

ubimkvol /dev/ubi0 -N rootfs_data -s 180MiB
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to create rootfs partition
        exit 1
fi

ubidetach -p /dev/mtd5
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to detach
        exit 1
fi

# unmount boot partition
umount /mnt
rc=$?
if [[ $rc != 0 ]] ; then
        echo Failed to unmount boot partition
        exit 1
fi

echo Done
