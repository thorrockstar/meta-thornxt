# remove unwanted components from image
IMAGE_INSTALL_remove = "\
	mpg123 \
	packagegroup-core-full-cmdline \
	lmbench \
	iperf \
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
	"

# add important components to image
IMAGE_INSTALL_append = "\
	glibc \
	glib-2.0 \
    \
	linux-firmware-atmel \
	linux-firmware-atmel-license \
    \
	linux-firmware-iwlwifi \
    \
	linux-firmware-ralink-license \
	linux-firmware-ralink \
    \
	linux-firmware-ti-connectivity-license \
	linux-firmware-wl12xx \
	linux-firmware-wl18xx \
    \
	linux-firmware-vt6656-license \
	linux-firmware-vt6656 \
    \
    linux-firmware-rtl-license \
    linux-firmware-rtl8192cu \
    linux-firmware-rtl8192ce \
    linux-firmware-rtl8192su \
    \
    linux-firmware-broadcom-license \
    linux-firmware-bcm4329 \
    linux-firmware-bcm4330 \
    linux-firmware-bcm4334 \
    linux-firmware-bcm43340 \
    linux-firmware-bcm4339 \
    linux-firmware-bcm43430 \
    linux-firmware-bcm4354 \
    \
    linux-firmware-atheros-license \
    linux-firmware-ar9170 \
    linux-firmware-carl9170 \
    linux-firmware-ath6k \
    linux-firmware-ath9k \
    \
    linux-firmware-ar3k \
    linux-firmware-ar3k-license \
    linux-firmware-ath10k \
    linux-firmware-ath10k-license \
    \
    linux-firmware-marvell-license \
    linux-firmware-sd8686 \
    linux-firmware-sd8688 \
    linux-firmware-sd8787 \
    linux-firmware-sd8797 \
    linux-firmware-sd8686 \
	"
