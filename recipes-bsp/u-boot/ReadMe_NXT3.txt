
Important Note:
----------------

In order to build the boot loader for the NX-T3, you will be in need to set the dedicated macro correct.

You find that in the file 'sama5d3_xplained_h.patch', like so...

    #define LIFT_APP_THOR_NXT_GENERATION  3  // Define that the Bootloader is made for the NX-T3 generation boards.

Set the value to 2 for NX-T2 and 3 for the newer NX-T3 boards.

--Roy Schneider (03-2021)
