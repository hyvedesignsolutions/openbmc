FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV="b172fa10db70d01b3f9626209decd8b10e6aafd0"
SRC_URI += "file://aspeed-bmc-hyve-hs9216.dts;subdir=git/arch/arm/boot/dts \
            file://0001-increase-rofs-space.patch \
            file://0002-Add-SGPIO-support.patch \
            file://hs9216.cfg \
           "
