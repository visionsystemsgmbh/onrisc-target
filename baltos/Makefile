#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=baltos
BOARDNAME:=VScom Baltos iR
FEATURES:=usb usbgadget targz ext4 nand fpu ubifs
CPU_TYPE:=cortex-a8
CPU_SUBTYPE:=vfpv3

#LINUX_VERSION:=3.18.21
#LINUX_VERSION:=3.18.131
#LINUX_VERSION:=4.14.91
#KERNEL_PATCHVER:=4.14
KERNEL_PATCHVER:=5.4

CFLAGS:=-Os -pipe
MAINTAINER:=VScom <contact@vscom.de>

#KERNELNAME:=zImage onrisc-baltos-ir-5221.dtb onrisc-baltos-ir-3220.dtb onrisc-baltos-ir-2110.dtb onrisc-baltos-dio-1080.dtb netcan.dtb netcom-plus-omap-uarts.dtb
KERNELNAME:=zImage dtbs

DEVICE_TYPE=developerboard

define Target/Description
	VScom Baltos iR
endef

include $(INCLUDE_DIR)/target.mk

$(eval $(call BuildTarget))
