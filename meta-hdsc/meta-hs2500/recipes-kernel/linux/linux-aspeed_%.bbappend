FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"
SRC_URI_append_romulus = " file://romulus.cfg"

SRC_URI += "file://aspeed-bmc-opp-hs2500.dts;subdir=git/arch/arm/boot/dts \
            "
