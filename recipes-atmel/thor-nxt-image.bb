DESCRIPTION = "An image for THOR-NX-T based boards with network and communication."
LICENSE = "MIT"
PR = "r1"

require thor-nxt-image.inc

IMAGE_INSTALL += "\
    packagegroup-base-usbhost \
    mpio \
    "

# remove unwanted components from image
IMAGE_INSTALL_remove = "\
	mpg123 \
	bash \
    bash-completion \
    nodejs \
    coreutils \
	packagegroup-core-full-cmdline \
    packagegroup-base-bluetooth \
    packagegroup-base-usbgadget \
	lmbench \
	atmel-wireless-firmware \
    hcitool \
	dtc \
	dtc-misc \
    python \
    python2 \
    python3 \
    python-core \
    python2-core \
    python3-core \
	python-pyserial \
	python-smbus \
	python-ctypes \
	python-pip \
	python-distribute \
	python-pycurl \	
	python-native \	
	linux-firmware \
	linux-firmware-atmel \
	linux-firmware-atmel-license \
    mchp-wireless-firmware \
    usbutils \
    evtest \
    libdrm-tests \
    9bit \
    rng-tools \
    bluez4 \
    bluez5 \
    wget \
    phytool \
    dhcp-server \
    dhcp-server-config \
    gdb \
    btmon \
    tcpdump \
	"

# add important components to image
IMAGE_INSTALL_append = "\
    glibc \
    glib-2.0 \
    gnutls \
    zeromq \
    dbus \
    gdbserver \
    busybox \
    ca-certificates \
	"

CUSTOMFILESPATH_EXTRA := "${THISDIR}/images/files"

ROOTFS_POSTPROCESS_COMMAND += " fix_udev_files ; fix_usr_files ; fix_firmware_files ; fix_interfaces_files ; cleanup_boot_overlay_files ; "

cleanup_boot_overlay_files () {
    rm -f $D/boot/*
}

fix_udev_files () {
    rm -f $D${sysconfdir}/udev/hwdb.bin
    rm -fr $D${sysconfdir}/udev/hwdb.d
    rm -fr $D${sysconfdir}/rc3.d/S03rng-tools
    rm -fr $D${sysconfdir}/rc5.d/S03rng-tools
    rm -fr $D${sysconfdir}/rc3.d/S20hostapd
    rm -fr $D${sysconfdir}/rc5.d/S20hostapd
}

fix_usr_files () {
    rm -fr $D/usr/games
    rm -fr $D/usr/lib/python3.8
    rm -fr $D/usr/include/python3.8
    rm -f $D/usr/lib/libpython*.so.*
}

fix_firmware_files () {
    rm -fr $D/usr/lib/firmware/*
    rm -fr $D/usr/share/sounds/alsa/*.wav
}

fix_interfaces_files () {
    install -c -m 0644 ${CUSTOMFILESPATH_EXTRA}/interfaces ${IMAGE_ROOTFS}/etc/network/
    install -c -m 0644 ${CUSTOMFILESPATH_EXTRA}/inittab ${IMAGE_ROOTFS}/etc/
}

