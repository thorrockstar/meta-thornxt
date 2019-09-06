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
    gdbserver \
    busybox \
    ca-certificates \
	"

