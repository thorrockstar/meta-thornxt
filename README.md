This layer provides support for the Thor-NXT platform reference boards
======================================================================

For more information about the Thor-NXT product line see:
http://www.thor.engineering

NeXt-Group - Open projects for lifts
http://www.next-group.org

Generic Linux & Open Source on Atmel micro controllers:
http://www.linux4sam.org


Supported SoCs / MACHINE names
==============================
- SAMA5D3 product family / sama5d3-xplained (THOR-NXT-2)


Sources
=======
- meta-thornxt
URI: git://github.com/thorrockstar/meta-thornxt.git
URI: https://github.com/thorrockstar/meta-thornxt.git
URI: ssh://git@github.com:thorrockstar/meta-thornxt.git
Branch: krogoth


Dependencies
============
This Layer depends on:

- meta-openembedded
URI: git://git.openembedded.org/meta-openembedded
URI: http://cgit.openembedded.org/meta-openembedded/
Branch: krogoth

- meta-atmel
URI: git://github.com/linux4sam/meta-atmel.git
URI: https://github.com/linux4sam/meta-atmel.git
Branch: krogoth

Optionally for SDK building:

- meta-qt5
URI: git://github.com/meta-qt5/meta-qt5.git
URI: https://github.com/meta-qt5/meta-qt5
Branch: krogoth


Build procedure
===============

0/ Create a directory
mkdir my_dir
cd my_dir

1/ Clone yocto/poky git repository with the proper branch ready.
git clone git://git.yoctoproject.org/poky

2/ Clone meta-openembedded git repository with the proper branch ready.
git clone git://git.openembedded.org/meta-openembedded

3/ Clone meta-qt5 git repository with the proper branch ready
git clone https://github.com/meta-qt5/meta-qt5.git

4/ Clone meta-atmel layer with the proper branch ready.
git clone https://github.com/linux4sam/meta-atmel.git

5/ Clone meta-thornxt layer with the proper branch ready.
git clone https://github.com/thorrockstar/meta-thornxt.git

6/ Enter the poky directory to configure the build system and start the build process
cd poky

7/ Initialize build directory
source oe-init-build-env build-atmel

8/ Add meta-thornxt layer to bblayer configuration file
vim conf/bblayers.conf

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BSPDIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True)) + '/../../..')}"

BBLAYERS ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  ${BSPDIR}/poky/meta-yocto-bsp \
  ${BSPDIR}/meta-atmel \
  ${BSPDIR}/meta-thornxt \
  ${BSPDIR}/meta-openembedded/meta-oe \
  ${BSPDIR}/meta-openembedded/meta-networking \
  ${BSPDIR}/meta-openembedded/meta-python \
  ${BSPDIR}/meta-qt5 \
  "

BLAYERS_NON_REMOVABLE ?= " \
  ${BSPDIR}/poky/meta \
  ${BSPDIR}/poky/meta-poky \
  "

8/ Edit local.conf to specify the machine, location of source archived, package type (rpm, deb or ipk)
Pick one MACHINE name from the "Supported SoCs / MACHINE names" chapter above
and edit the "local.conf" file. Here is an example:

vim conf/local.conf
[...]
MACHINE ??= "sama5d3-xplained"
[...]
DL_DIR ?= "your_download_directory_path"
[...]
PACKAGE_CLASSES ?= "package_ipk"
[...]
USER_CLASSES ?= "buildstats image-mklibs"

To get better performance, use the "poky-atmel" distribution by also adding that
line:
DISTRO = "poky-atmel"

9/ Build Thor demo images
bitbake atmel-xplained-demo-image

Typical bitbake output
======================
Build Configuration:
BB_VERSION        = "1.34.0"
BUILD_SYS         = "i686-linux"
NATIVELSBSTRING   = "universal"
TARGET_SYS        = "arm-poky-linux-gnueabi"
MACHINE           = "sama5d3-xplained"
DISTRO            = "poky-atmel"
DISTRO_VERSION    = "2.3"
TUNE_FEATURES     = "arm armv7a vfp thumb callconvention-hard cortexa5"
TARGET_FPU        = "hard"
meta              
meta-poky         
meta-yocto-bsp    = "master:bd063fa288b49b6e3ea77982d0ccc46610feb1ad"
meta-atmel        = "master:41cffff1bd4cc0e553b5b4a170cdbec9dec18443"
meta-thornxt      = "master:bb4a0e1cb51ce127b04db7bc8ad973e2cca9e672"
meta-oe           
meta-networking   
meta-python       = "master:b063789560bfb9c60a7a15277b5b3a9839b5ba74"
meta-qt5          = "master:6605c48f3a900da26425ef31d83eb1c95d551531"


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
