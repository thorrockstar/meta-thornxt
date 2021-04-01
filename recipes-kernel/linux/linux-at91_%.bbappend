FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI += " \
	file://defconfig_thor \
	file://spidev.patch;patch=1 \
	file://at91_can.patch;patch=1 \
	file://atmel_ssm2518.patch;patch=1 \
	file://Kconfig.patch;patch=1 \
	file://Makefile.patch;patch=1 \
	file://panel-simple.patch;patch=1 \
	file://at91-sama5d3_thor-nxt2.dts;subdir=git/arch/${ARCH}/boot/dts \
	file://at91-sama5d3_thor-nxt3.dts;subdir=git/arch/${ARCH}/boot/dts \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

MACHINE_FEATURES_remove = "camera"

KERNEL_DEVICETREE += "at91-sama5d3_thor-nxt2.dtb"
KERNEL_DEVICETREE += "at91-sama5d3_thor-nxt3.dtb"

do_configure_prepend() {
    mv ${WORKDIR}/defconfig_thor ${WORKDIR}/defconfig
    cp ${WORKDIR}/defconfig ${WORKDIR}/build/.config
}
