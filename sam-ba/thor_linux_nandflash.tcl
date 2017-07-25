## Files to load
set bootstrapFile       "sama5d3_xplained-nandflashboot-uboot.bin"
set ubootFile           "u-boot-sama5d3-xplained.bin"
set kernelFile          "zImage-sama5d3_xplained.bin"
set rootfsFile          "atmel-xplained-demo-image-sama5d3_xplained.ubi"

## board variant
set boardFamily "at91-sama5d3"
set board_suffix "_xplained"

## now call common script
source thor_script_linux_nandflash.tcl
