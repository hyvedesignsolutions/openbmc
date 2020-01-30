FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"
SRC_URI_append_hs2500 = " file://hs2500.cfg"

SRC_URI += "file://aspeed-bmc-opp-hs2500.dts;subdir=git/arch/arm/boot/dts \
            file://0001-menuconfig-mconf-cfg-Allow-specification-of-ncurses-.patch \
            "
