FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://aspeed-bmc-hyve-hs9216.dts;subdir=git/arch/arm/boot/dts \
            file://hs9216.cfg \
           "
