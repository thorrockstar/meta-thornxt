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
- SAMA5D3 based THOR-NX-T2/3 lift controller boards


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

0/ Create a directory.  
    mkdir poky  
    cd poky

1/ Clone yocto/poky git repository with the proper branch ready.  
    git clone git://git.yoctoproject.org/poky -b dunfell

2/ Clone meta-openembedded git repository with the proper branch ready.  
    git clone git://git.openembedded.org/meta-openembedded -b dunfell

3/ Clone meta-atmel layer with the proper branch ready.  
    git clone git://github.com/linux4sam/meta-atmel.git -b dunfell

4/ Clone meta-thornxt layer with the proper branch ready.  
    git clone git://github.com/thorrockstar/meta-thornxt.git -b dunfell

5/ Enter the poky directory to configure the build system and start the build process.  
   cd poky

6/ Initialize build directory and set compiler.  
    source oe-init-build-env build-atmel

7/ Add meta-thornxt layer to bblayer configuration file.  
    vi conf/bblayers.conf

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
      "

    BLAYERS_NON_REMOVABLE ?= " \
      ${BSPDIR}/poky/meta \
      ${BSPDIR}/poky/meta-poky \
      "

8/ Edit local.conf to specify the machine, location of source archived, package type (rpm, deb or ipk)
Pick one MACHINE name from the "Supported SoCs / MACHINE names" chapter above
and edit the "local.conf" file. Here is an example:  
    vi conf/local.conf

    [...]
    MACHINE ??= "sama5d3-xplained"
    [...]
    PACKAGE_CLASSES ?= "package_ipk"
    [...]
    USER_CLASSES ?= "buildstats image-mklibs"
    [...]
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
    BB_VERSION           = "1.46.0"
    BUILD_SYS            = "x86_64-linux"
    NATIVELSBSTRING      = "universal"
    TARGET_SYS           = "arm-poky-linux-gnueabi"
    MACHINE              = "sama5d3-xplained"
    DISTRO               = "poky-atmel"
    DISTRO_VERSION       = "3.1.12"
    TUNE_FEATURES        = "arm vfp cortexa5 thumb callconvention-hard"
    TARGET_FPU           = "hard"
    meta                 
    meta-poky            
    meta-yocto-bsp       = "dunfell:cf5a00721f721d5077c73d1f4e812e5c79833fba"
    meta-atmel           = "dunfell:20eeec4910f1214b9099f5276a944e5d281b70ee"
    meta-thornxt         = "dunfell:98675d04633a2710a9f705e2d059d3dc9c70676c"
    meta-oe              
    meta-networking      
    meta-python          = "dunfell:69f94af4d91215e7d4e225bab54bf3bcfee42f1c"

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
