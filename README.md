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

0/ Create a directory.  
    mkdir poky  
    cd poky

1/ Clone yocto/poky git repository with the proper branch ready.  
    git clone git://git.yoctoproject.org/poky -b rocko

2/ Clone meta-openembedded git repository with the proper branch ready.  
    git clone git://git.openembedded.org/meta-openembedded -b rocko

3/ Clone meta-qt5 git repository with the proper branch ready.  
    git clone git://github.com/meta-qt5/meta-qt5.git -b rocko

4/ Clone meta-atmel layer with the proper branch ready.  
    git clone git://github.com/linux4sam/meta-atmel.git -b rocko

5/ Clone meta-thornxt layer with the proper branch ready.  
    git clone git://github.com/thorrockstar/meta-thornxt.git -b rocko

6/ Enter the poky directory to configure the build system and start the build process.  
   cd poky

7/ Initialize build directory and set compiler.  
    export CROSS_COMPILE=arm-linux-gnueabi-  
    source oe-init-build-env build-atmel

8/ Add meta-thornxt layer to bblayer configuration file.  
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
      ${BSPDIR}/meta-qt5 \
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
    DISTRO ?= "poky-atmel"

**IMPORTANT**

9/ Double check that in the kernel configuration **'General Setup->Timers subsystem->High Resolution Timer Support'**
has been turned **off** as well as **'General Setup->Timers subsystem->Timer tick handling'** is set to **'Periodic timer ticks'**.
This should be done by the 'defconfig' but double check before building because it is cruicial.

10/ Build Thor demo images  
    bitbake atmel-xplained-demo-image

Typical bitbake output
======================
    Build Configuration:
    BB_VERSION           = "1.36.0"
    BUILD_SYS            = "i686-linux"
    NATIVELSBSTRING      = "ubuntu-16.04"
    TARGET_SYS           = "arm-poky-linux-gnueabi"
    MACHINE              = "sama5d3-xplained"
    DISTRO               = "poky-atmel"
    DISTRO_VERSION       = "2.4.3"
    TUNE_FEATURES        = "arm armv7a vfp thumb callconvention-hard cortexa5"
    TARGET_FPU           = "hard"
    meta                 
    meta-poky            
    meta-yocto-bsp       = "rocko:9ed1178c87afce997d5a21cadae7461fb6bb48da"
    meta-atmel           = "rocko:d77d8716376781aab08cb68fdc68361e6feeb154"
    meta-thornxt         = "rocko:c31f1c50664d7539d6a551d25e5768737494548b"
    meta-oe              
    meta-networking      
    meta-python          = "rocko:352531015014d1957d6444d114f4451e241c4d23"
    meta-qt5             = "rocko:682ad61c071a9710e9f9d8a32ab1b5f3c14953d1"

Note/Issues
===========

You may encounter the problem that after bulding the image 'newusers' and 'chpassw' gives you an error in the way of:

    root@sama5d3-xplained:~# newusers
    newusers: PAM: Authentication failure
    root@sama5d3-xplained:~# chpasswd
    chpasswd: PAM: Authentication failure

To fix this you will need this patch that modifies the shadow files in the 'meta/recipes-extended/shadow/files/pam.d' folder before building the Yocto image.

     --- a/meta/recipes-extended/shadow/files/pam.d/chpasswd
     +++ b/meta/recipes-extended/shadow/files/pam.d/chpasswd
     @@ -1,4 +1,6 @@
     # The PAM configuration file for the Shadow 'chpasswd' service
     #
     +auth       sufficient   pam_rootok.so
     +account    required     pam_permit.so
      password   include      common-password


     --- a/meta/recipes-extended/shadow/files/pam.d/newusers
     +++ b/meta/recipes-extended/shadow/files/pam.d/newusers
     @@ -1,4 +1,6 @@
      # The PAM configuration file for the Shadow 'newusers' service
      #
     +auth       sufficient   pam_rootok.so
     +account    required     pam_permit.so
      password   include      common-password

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
