#
# Copyright (C) 2021 VS Vision Systems GmbH
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Image/Prepare
	cp $(LINUX_DIR)/arch/arm/boot/zImage $(KDIR)/zImage
	cp $(KDIR)/zImage $(BIN_DIR)/openwrt-$(BOARD)-zImage
	cp $(LINUX_DIR)/arch/arm/boot/dts/am335x-baltos-*.dtb $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/kernel-fit-intree.its $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/barebox-am33xx-baltos.img $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/barebox-am33xx-baltos-mlo.img $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/genimage-barebox-baltos.cfg $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/uEnv.txt $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/uImage $(BIN_DIR)/
	cp $(PLATFORM_DIR)/image/mksdcard.sh $(BIN_DIR)/

	$(INSTALL_DIR) $(TARGET_DIR)/boot
	cp $(LINUX_DIR)/arch/arm/boot/dts/am335x-baltos-*.dtb $(TARGET_DIR)/boot/
	$(CP) $(BIN_DIR)/openwrt-$(BOARD)-zImage $(TARGET_DIR)/boot/
	ln -sf openwrt-$(BOARD)-zImage $(TARGET_DIR)/boot/zImage
	ln -sf am335x-baltos-ir2110.dtb $(TARGET_DIR)/boot/onrisc-baltos-ir-2110.dtb
	ln -sf am335x-baltos-ir3220.dtb $(TARGET_DIR)/boot/onrisc-baltos-ir-3220.dtb
	ln -sf am335x-baltos-ir5221.dtb $(TARGET_DIR)/boot/onrisc-baltos-ir-5221.dtb

	ln -sf  busybox $(TARGET_DIR)/bin/adduser
	ln -sf  /bin/busybox $(TARGET_DIR)/usr/bin/passwd
endef

define Image/BuildKernel
	cp $(KDIR)/zImage $(BIN_DIR)/openwrt-$(BOARD)-zImage
endef

define Image/Build
	$(call Image/Build/$(1),$(1))
endef

define Image/Build/jffs2-64k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/openwrt-$(BOARD)-$(1).img bs=65536 conv=sync
endef

define Image/Build/jffs2-128k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/openwrt-$(BOARD)-$(1).img bs=131072 conv=sync
endef

define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/openwrt-$(BOARD)-$(1).img bs=131072 conv=sync
endef

define Image/Build/ext4
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/openwrt-$(BOARD)-$(1).img bs=131072 conv=sync
endef

define Image/InstallKernel

 ifneq ($(CONFIG_TARGET_ROOTFS_INCLUDE_KERNEL),)
	$(INSTALL_DIR) $(TARGET_DIR)/boot
   ifneq ($(CONFIG_TARGET_ROOTFS_INCLUDE_UIMAGE),)
	$(CP) $(BIN_DIR)/$(IMG_PREFIX)-uImage $(TARGET_DIR)/boot/
	ln -sf $(IMG_PREFIX)-uImage $(TARGET_DIR)/boot/uImage
   endif
   ifneq ($(CONFIG_TARGET_ROOTFS_INCLUDE_ZIMAGE),)
	$(CP) $(BIN_DIR)/$(IMG_PREFIX)-zImage $(TARGET_DIR)/boot/
	ln -sf $(IMG_PREFIX)-zImage $(TARGET_DIR)/boot/zImage
   endif
   ifneq ($(CONFIG_TARGET_ROOTFS_INCLUDE_FIT),)
	mkimage -f $(BIN_DIR)/kernel-fit-intree.its $(BIN_DIR)/kernel-fit.itb
	$(CP) $(BIN_DIR)/kernel-fit.itb $(TARGET_DIR)/boot/
   endif
 endif
endef

$(eval $(call BuildImage))
