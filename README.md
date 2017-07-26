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


Build procedure
===============

0/ Create a directory
mkdir poky
cd poky

1/ Clone yocto/poky git repository with the proper branch ready.
git clone git://git.yoctoproject.org/poky

2/ Clone meta-openembedded git repository with the proper branch ready.
git clone git://git.openembedded.org/meta-openembedded

3/ Clone meta-qt5 git repository with the proper branch ready
git clone git://github.com/meta-qt5/meta-qt5.git

4/ Clone meta-atmel layer with the proper branch ready.
git clone git://github.com/linux4sam/meta-atmel.git

5/ Clone meta-thornxt layer with the proper branch ready.
git clone git://github.com/thorrockstar/meta-thornxt.git

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

**IMPORTANT**

9/ Double check that in the kernel configuration **'General Setup->Timers subsystem->High Resolution Timer Support'**
has been turned **off** as well as **'General Setup->Timers subsystem->Timer tick handling'** is set to **'Periodic timer ticks'**.
This should be done by the 'defconfig' but double check before building because it is cruicial.

10/ Build Thor demo images
bitbake atmel-xplained-demo-image

Typical bitbake output
======================
    Build Configuration:
    BB_VERSION        = "1.32.0"
    BUILD_SYS         = "i686-linux"
    NATIVELSBSTRING   = "Ubuntu-16.04"
    TARGET_SYS        = "arm-poky-linux-gnueabi"
    MACHINE           = "sama5d3-xplained"
    DISTRO            = "poky-atmel"
    DISTRO_VERSION    = "2.2.2"
    TUNE_FEATURES     = "arm armv7a vfp thumb            callconvention-hard            cortexa5"
    TARGET_FPU        = "hard"
    meta              
    meta-poky         
    meta-yocto-bsp    = "master:d05941ae4567def4a288894717e5f550da246107"
    meta-atmel        = "master:8c79606d3e73179506a6bbc40406f2c3aa9bf40e"
    meta-thornxt      = "master:824b7b7d95d1837806d9c9c454ae02ba6550968b"
    meta-oe           
    meta-networking   
    meta-python       = "master:fe5c83312de11e80b85680ef237f8acb04b4b26e"
    meta-qt5          = "master:3601fd2c5306ac6d5d0d536e0be8cbb90da9b4c1"

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
