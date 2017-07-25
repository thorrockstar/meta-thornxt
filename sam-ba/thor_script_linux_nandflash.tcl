# ----------------------------------------------------------------------------
#         ATMEL Microcontroller
# ----------------------------------------------------------------------------
# Copyright (c) 2013, Atmel Corporation
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# - Redistributions of source code must retain the above copyright notice,
# this list of conditions and the disclaimer below.
#
# Atmel's name may not be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# DISCLAIMER: THIS SOFTWARE IS PROVIDED BY ATMEL "AS IS" AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT ARE
# DISCLAIMED. IN NO EVENT SHALL ATMEL BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# ----------------------------------------------------------------------------

################################################################################
#  proc uboot_env: Convert u-boot variables in a string ready to be flashed
#                  in the region reserved for environment variables
################################################################################
proc set_uboot_env {nameOfLstOfVar} {
    upvar $nameOfLstOfVar lstOfVar
    
    # sector size is the size defined in u-boot CFG_ENV_SIZE
    set sectorSize [expr 0x20000 - 5]

    set strEnv [join $lstOfVar "\0"]
    while {[string length $strEnv] < $sectorSize} {
        append strEnv "\0"
    }
    # \0 between crc and strEnv is the flag value for redundant environment
    set strCrc [binary format i [::vfs::crc $strEnv]]
    return "$strCrc\0$strEnv"
}

################################################################################
#  Main script: Load the linux demo in NandFlash,
#               Update the environment variables
################################################################################

################################################################################

# check for proper variable initialization
if {! [info exists boardFamily]} {
   puts "-E- === Board family not defined ==="
   exit
}

## Additional files to load
append dtbFile $boardFamily $board_suffix ".dtb"
set ubootEnvFile	"ubootEnvtFileNandFlash.bin"

## Now check for the needed files
if {! [file exists $bootstrapFile]} {
   puts "-E- === AT91Bootstrap file not found ==="
   exit
}

if {! [file exists $ubootFile]} {
   puts "-E- === U-Boot file not found ==="
   exit
}

if {! [file exists $kernelFile]} {
   puts "-E- === Linux kernel file not found ==="
   exit
}

if {! [file exists $dtbFile]} {
   puts "-E- === Unknown $boardFamily + board $board_suffix combination ==="
   exit
}

if {! [file exists $rootfsFile]} {
   puts "-E- === Rootfs file not found ==="
   exit
}

set pmeccConfig 0xc0902405

## NandFlash Mapping
set bootStrapAddr	0x00000000
set ubootAddr		0x00040000
set ubootEnvAddr	0x000c0000
set dtbAddr			0x00180000
set kernelAddr		0x00200000
set rootfsAddr		0x00800000

## u-boot variable
set kernelLoadAddr 0x22000000
set dtbLoadAddr	0x21000000

## NandFlash Mapping
set kernelSize	[format "0x%08X" [file size $kernelFile]]
set dtbSize	[format "0x%08X" [file size $dtbFile]]

set bootCmd "bootcmd=nand read $dtbLoadAddr $dtbAddr $dtbSize; nand read $kernelLoadAddr $kernelAddr $kernelSize; bootz $kernelLoadAddr - $dtbLoadAddr"

lappend u_boot_variables \
    "bootdelay=0" \
    "baudrate=115200" \
    "stdin=serial" \
    "stdout=serial" \
    "stderr=serial" \
	"ipaddr=192.168.178.142" \
	"netmask=255.255.255.0" \
    "bootargs=console=ttyS0,115200 mtdparts=atmel_nand:256k(bootstrap)ro,512k(uboot)ro,256k(env),256k(env_redundant),256k(spare),512k(dtb),6M(kernel)ro,-(rootfs) rootfstype=ubifs ubi.mtd=7 root=ubi0:rootfs rw" \
    "$bootCmd"


puts "-I- === Initialize the NAND access ==="
NANDFLASH::Init

if {$pmeccConfig != "none"} {
   puts "-I- === Enable PMECC OS Parameters ==="
   NANDFLASH::NandHeaderValue HEADER $pmeccConfig
}

puts "-I- === Erase all the NAND flash blocs and test the erasing ==="
NANDFLASH::EraseAllNandFlash

puts "-I- === Load the bootstrap in the first sector ==="
if {$pmeccConfig != "none"} {
   NANDFLASH::SendBootFilePmeccCmd $bootstrapFile
} else {
   NANDFLASH::sendBootFile $bootstrapFile
}

puts "-I- === Load the u-boot in the next sectors ==="
send_file {NandFlash} "$ubootFile" $ubootAddr 0 

puts "-I- === Load the u-boot environment variables ==="
set fh [open "$ubootEnvFile" w]
fconfigure $fh -translation binary
puts -nonewline $fh [set_uboot_env u_boot_variables]
close $fh
send_file {NandFlash} "$ubootEnvFile" $ubootEnvAddr 0 

puts "-I- === Load the Kernel image and device tree database ==="
send_file {NandFlash} "$dtbFile" $dtbAddr 0
send_file {NandFlash} "$kernelFile" $kernelAddr 0

if {$pmeccConfig != "none"} {
   puts "-I- === Enable trimffs ==="
   NANDFLASH::NandSetTrimffs 1
}

puts "-I- === Load the linux file system ==="
send_file {NandFlash} "$rootfsFile" $rootfsAddr 0

puts "-I- === DONE. ==="
