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
