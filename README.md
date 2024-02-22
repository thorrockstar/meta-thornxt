This layer provides support for the Thor-NXT platform reference boards
======================================================================

For more information about the Thor-NXT product line see:
https://www.thor.engineering

NeXt-Group - Open projects for lifts
https://www.next-group.org

Generic Linux & Open Source on Atmel micro controllers:
https://www.linux4sam.org


Supported SoCs / MACHINE names
==============================
- SAMA5D3 based THOR-NX-T2/3(Nova) and Nous lift controller boards


Sources
=======
- meta-thornxt
URI: git://github.com/thorrockstar/meta-thornxt.git
URI: https://github.com/thorrockstar/meta-thornxt.git
URI: ssh://git@github.com:thorrockstar/meta-thornxt.git


Dependencies
============
This Layer depends on:

- meta-openembedded
URI: git://git.openembedded.org/meta-openembedded
URI: http://cgit.openembedded.org/meta-openembedded/

- meta-atmel
URI: git://github.com/linux4sam/meta-atmel.git
URI: https://github.com/linux4sam/meta-atmel.git

Optionally for SDK building:

- meta-qt5
URI: git://github.com/meta-qt5/meta-qt5.git
URI: https://github.com/meta-qt5/meta-qt5


Requisities
===========

Build has been tested under Ubuntu 22.04 LTS. Anyway you need to install these required packages:

    $ sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool file locales libacl1
    $ sudo locale-gen en_US.UTF-8

    $ sudo apt install make python3-pip inkscape texlive-latex-extra
    $ sudo pip3 install sphinx sphinx_rtd_theme pyyaml


Build procedure
===============

0/ Create a directory.  

    mkdir kirkstone_sama
    cd kirkstone_sama

1/ Clone yocto/poky git repository with the proper branch ready.  

    git clone https://git.yoctoproject.org/poky && cd poky && git checkout -b kirkstone yocto-4.0.13 && cd -

2/ Clone meta-openembedded git repository with the proper branch ready.  

    git clone git://git.openembedded.org/meta-openembedded && cd meta-openembedded && git checkout -b kirkstone 79a6f6 && cd -

3/ Clone meta-atmel layer with the proper branch ready.  

    git clone https://github.com/linux4sam/meta-atmel.git -b kirkstone

4/ Clone meta-arm layer with the proper branch ready

    git clone https://git.yoctoproject.org/meta-arm && cd meta-arm && git checkout -b kirkstone yocto-4.0.1 && cd -

5/ Clone meta-thornxt layer with the proper branch ready.  

    git clone https://github.com/thorrockstar/meta-thornxt.git -b kirkstone

6/ Enter the poky directory to configure the build system and start the build process.

    cd poky

7/ Inside the .templateconf file, you will need to modify the TEMPLATECONF variable to match the path to the meta-atmel layer "conf" directory:

    gedit .templateconf

    export TEMPLATECONF=${TEMPLATECONF:-../meta-atmel/conf}

8/ Initialize build directory and set compiler.  

    source oe-init-build-env build-microchip

9/ Add meta-thornxt layer to bblayer configuration file.

**Make sure that you have no white spaces left to "BBLAYERS ?=" and the other variables when editing the text block.**

    gedit conf/bblayers.conf

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BSPDIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../../..')}"

BBLAYERS ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  ${BSPDIR}/poky/meta-yocto-bsp \
  ${BSPDIR}/meta-openembedded/meta-oe \
  ${BSPDIR}/meta-openembedded/meta-networking \
  ${BSPDIR}/meta-openembedded/meta-python \
  ${BSPDIR}/meta-atmel \
  ${BSPDIR}/meta-thornxt \
  ${BSPDIR}/meta-arm/meta-arm \
  ${BSPDIR}/meta-arm/meta-arm-toolchain \
  "

BLAYERS_NON_REMOVABLE ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  "

10/ Edit local.conf to specify the machine, location of source archived, package type (rpm, deb or ipk)
Pick one MACHINE name from the "Supported SoCs / MACHINE names" chapter above
and edit the "local.conf" file. Here is an example:  

**Make sure that you have no white spaces left to "MACHINE ??=" and the other variables when editing the text block.**

    gedit conf/local.conf

[...]  
MACHINE ??= "sama5d3-xplained"  
[...]  
PACKAGE_CLASSES ?= "package_ipk"  
[...]  
USER_CLASSES ?= "buildstats"  
[...]  
INIT_MANAGER = "sysvinit"  
[...]  
DISTRO ?= "poky-atmel"  
[...]  
ENABLE_BINARY_LOCALE_GENERATION = "1"  
[...]  
GLIBC_SPLIT_LC_PACKAGES = "0"  
[...]  
GLIBC_GENERATE_LOCALES += "en_US.UTF-8"  
[...]  
IMAGE_LINGUAS += "en-us"  

**IMPORTANT**

11/ Double check that in the kernel configuration **'General Setup->Timers subsystem->High Resolution Timer Support'**
has been turned **off** as well as **'General Setup->Timers subsystem->Timer tick handling'** is set to **'Periodic timer ticks'**.
This should be done by the 'defconfig' but double check before building because it is cruicial.

12/ Build Thor demo images  

    bitbake thor-nxt-image

Typical bitbake output
======================
    Build Configuration:
    BB_VERSION           = "2.0.0"
    BUILD_SYS            = "x86_64-linux"
    NATIVELSBSTRING      = "universal"
    TARGET_SYS           = "arm-poky-linux-gnueabi"
    MACHINE              = "sama5d3-xplained"
    DISTRO               = "poky-atmel"
    DISTRO_VERSION       = "4.0.13"
    TUNE_FEATURES        = "arm vfp cortexa5 thumb callconvention-hard"
    TARGET_FPU           = "hard"
    meta                 
    meta-poky            
    meta-yocto-bsp       = "kirkstone:e51bf557f596c4da38789a948a3228ba11455e3c"
    meta-oe              
    meta-networking      
    meta-python          = "kirkstone:79a6f60dabad9e5b0e041efa91379447ef030482"
    meta-atmel           = "kirkstone:128bf04cb75902e239a145f0e84f6147aef2ff4b"
    meta-thornxt         = "kirkstone:96c8dcd70f12b45a8b8f6071b440e09d65fd8c06"
    meta-arm             
    meta-arm-toolchain   = "kirkstone:bafd1d013c2470bcec123ba4eb8232ab879b2660"

Contributing
============
To contribute to this layer you should submit the patches for review to:
the github pull-request facility directly. Anyway, don't forget to
Cc the maintainers.

AT91 Forum:
http://www.at91.com/discussions/

for some useful guidelines to be followed when submitting patches:
http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

Maintainers:
Roy Schneider <roy@thor.engineering>

When creating patches insert the [meta-thornxt] tag in the subject, for example
use something like:
git format-patch -s --subject-prefix='meta-thornxt][PATCH' <origin>
