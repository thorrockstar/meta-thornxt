do_install_append() {
	rm -f -r ${D}/lib/firmware/radeon
	rm -f -r ${D}/lib/firmware/nvidia
	rm -f -r ${D}/lib/firmware/liquidio
	rm -f -r ${D}/lib/firmware/bnx2
	rm -f -r ${D}/lib/firmware/bnx2x
	rm -f -r ${D}/lib/firmware/ueagle-atm
	rm -f -r ${D}/lib/firmware/brcm
	rm -f -r ${D}/lib/firmware/amdgpu
	rm -f -r ${D}/lib/firmware/sb16
	rm -f -r ${D}/lib/firmware/moxa
	rm -f -r ${D}/lib/firmware/yamaha
	rm -f -r ${D}/lib/firmware/advansys
	rm -f -r ${D}/lib/firmware/adaptec
	rm -f -r ${D}/lib/firmware/acenic
	rm -f -r ${D}/lib/firmware/3com
	rm -f -r ${D}/lib/firmware/edgeport
	rm -f -r ${D}/lib/firmware/yam
	rm -f -r ${D}/lib/firmware/vicam
	rm -f -r ${D}/lib/firmware/korg
	rm -f -r ${D}/lib/firmware/keyspan
	rm -f -r ${D}/lib/firmware/keyspan_pda
	rm -f -r ${D}/lib/firmware/emi62
    rm -f -r ${D}/lib/firmware/emi26
    rm -f -r ${D}/lib/firmware/dsp56k
}