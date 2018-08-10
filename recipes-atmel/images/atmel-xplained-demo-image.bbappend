# remove unwanted components from image
IMAGE_INSTALL_remove = "\
	mpg123 \
	packagegroup-core-full-cmdline \
	lmbench \
	atmel-wireless-firmware \
	dtc \
	dtc-misc \
	python-pyserial \
	python-smbus \
	python-ctypes \
	python-pip \
	python-distribute \
	python-pycurl \	
	linux-firmware \
	linux-firmware-atmel \
	linux-firmware-atmel-license \
	"

# add important components to image
IMAGE_INSTALL_append = "\
	glibc \
	glib-2.0 \
	"

# Fix PAM files for chpassw and newusers.

PAMFILESPATH_EXTRA := "${THISDIR}/files"

ROOTFS_POSTPROCESS_COMMAND += " fix_pam_files ; fix_udev_files ; "

fix_pam_files () {
    install -c -m 0644 ${PAMFILESPATH_EXTRA}/chpasswd ${IMAGE_ROOTFS}/etc/pam.d/
    install -c -m 0644 ${PAMFILESPATH_EXTRA}/newusers ${IMAGE_ROOTFS}/etc/pam.d/
}

fix_udev_files () {
    install -c -m 0755 ${PAMFILESPATH_EXTRA}/systemd-udevd ${IMAGE_ROOTFS}/etc/init.d/
}
