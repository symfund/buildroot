#!/bin/sh

MODULES_DIR=board/nuvoton/ma35d1/modules/5.4.181
MODULES_TDIR=$TARGET_DIR/lib/modules/5.4.181
GFXDRIVERS_TDIR=$TARGET_DIR/usr/lib/directfb-1.7-7/gfxdrivers

if grep -Eq "^BR2_LINUX_KERNEL_MA35D1_5_10_VERSION=y$" ${BR2_CONFIG}; then
	MODULES_DIR=board/nuvoton/ma35d1/modules/5.10.140
	MODULES_TDIR=$TARGET_DIR/lib/modules/5.10.140
fi


RESIZE_FILE=${TARGET_DIR}/etc/init.d/S50resize
cp $MODULES_DIR/../../resize.sh ${TARGET_DIR}/etc/
if [ -f ${RESIZE_FILE} ]; then
        rm ${RESIZE_FILE}
fi

if grep -Eq "^BR2_MA35D1_RESIZE_SD_MAX=y$" ${BR2_CONFIG}; then
	export $(grep "BR2_MA35D1_RESIZE_DISK_DRIVE=" $BR2_CONFIG | sed 's/\"//g')
	export $(grep "BR2_MA35D1_RESIZE_DISK_NUM=" $BR2_CONFIG | sed 's/\"//g')
	echo "#!/bin/sh" >> ${RESIZE_FILE}
	echo "/etc/resize.sh ${BR2_MA35D1_RESIZE_DISK_DRIVE} ${BR2_MA35D1_RESIZE_DISK_NUM}" >> ${RESIZE_FILE}
	chmod 755 ${RESIZE_FILE}
fi

display_status=$(output/host/bin/fdtget output/images/Image.dtb /display@40260000 status)
if test "$display_status" = "okay" ; then
	install -d -m 755 ${MODULES_TARGET_TDIR}
	install -d -m 755 ${GFXDRIVERS_TDIR}
	cp ${MODULES_DIR}/*.ko ${MODULES_TDIR}/
	cp ${MODULES_DIR}/../libdirectfb_gal.so ${GFXDRIVERS_TDIR}/
	cp ${MODULES_DIR}/../libGAL.so ${TARGET_DIR}/usr/lib/
	cp ${MODULES_DIR}/../modules.sh ${TARGET_DIR}/etc/profile.d/
fi

if grep -Eq "^BR2_PACKAGE_OPENSSH_SERVER=y$" ${BR2_CONFIG}; then
        cp -f ~/Projects/ma35d1-portal/rootfs/etc/ssh/sshd_config ${TARGET_DIR}/etc/ssh/sshd_config
fi

if grep -Eq "^BR2_PACKAGE_SHAIRPORT_SYNC=y$" ${BR2_CONFIG}; then
	cp -f ~/Projects/ma35d1-portal/rootfs/etc/shairport-sync.conf ${TARGET_DIR}/etc
fi

# adc@40420000
# i2c@40850000
adc_status=$(output/host/bin/fdtget output/images/Image.dtb /adc@40420000 status)
if test "$adc_status" = "okay" ; then
	if ! grep -Eq "^BR2_PACKAGE_WESTON=y$" ${BR2_CONFIG}; then
		cp -f ~/Projects/ma35d1-portal/rootfs/etc/profile.d/tslib.sh ${TARGET_DIR}/etc/profile.d/tslib.sh
		chmod +x ${TARGET_DIR}/etc/profile.d/tslib.sh
	fi
fi

# Static IP address
cp -f ~/Projects/ma35d1-portal/rootfs/etc/network/interfaces ${TARGET_DIR}/etc/network/interfaces
