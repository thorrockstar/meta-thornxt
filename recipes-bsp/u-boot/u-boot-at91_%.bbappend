
FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI += "file://eth.patch;patch=1"
SRC_URI += "file://sama5d3_xplained_nandflash_defconfig.patch;patch=1"
SRC_URI += "file://sama5d3_devices.patch;patch=1"
SRC_URI += "file://sama5d3_xplained.patch;patch=1"
SRC_URI += "file://sama5d3_xplained_h.patch;patch=1"
SRC_URI += "file://lcd.patch;patch=1"
SRC_URI += "file://at91-sama5_common_h.patch;patch=1"
SRC_URI += "file://cache.patch;patch=1"

