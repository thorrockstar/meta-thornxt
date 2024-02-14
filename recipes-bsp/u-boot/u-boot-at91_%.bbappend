
FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI += "file://eth.patch;patch=1"
SRC_URI += "file://sama5d3_xplained_nandflash_defconfig.patch;patch=1"
SRC_URI += "file://lcd.patch;patch=1"
SRC_URI += "file://cache.patch;patch=1"
SRC_URI += "file://sama5d3_devices.patch;patch=1"
SRC_URI += "file://sama5d3_xplained_h.patch;patch=1"
SRC_URI += "file://sama5d3_xplained.patch;patch=1"


# U-Boot Environments for AT91 boards

SRC_URI_append = " file://envs/"

ENV_FILENAME = "uboot.env"
ENV_FILEPATH = "${WORKDIR}/envs"

do_compile_append() {
    if [ -e "${ENV_FILEPATH}/${MACHINE}.txt" ]; then
        echo "Compile U-Boot environment for ${MACHINE}"
        ${B}/tools/mkenvimage -r -s ${UBOOT_ENV_SIZE} -p 0x00 ${ENV_FILEPATH}/${MACHINE}.txt -o ${ENV_FILENAME}
    else
        echo "No custom environment available for ${MACHINE}."
    fi
}

do_deploy_append() {
    if [ -e  ${B}/${ENV_FILENAME} ]; then
        install -Dm 0644 ${B}/${ENV_FILENAME} ${DEPLOYDIR}
    fi
}
