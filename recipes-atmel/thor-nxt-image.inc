IMAGE_FEATURES += "ssh-server-openssh"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    kernel-modules \
    lrzsz \
    setserial \
    opkg \
    iperf3 \
    alsa-utils \
    i2c-tools \
    devmem2 \
    dosfstools \
    mtd-utils \
    mtd-utils-ubifs \
    iproute2 \
    iptables \
    bridge-utils \
    can-utils \
    net-tools \
    nftables \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    "

inherit core-image

