
FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI += "file://eth.patch;patch=1"
SRC_URI += "file://sama5d3_devices.patch;patch=1"
SRC_URI += "file://sama5d3_xplained.patch;patch=1"
SRC_URI += "file://sama5d3_xplained_h.patch;patch=1"
SRC_URI += "file://lcd.patch;patch=1"
