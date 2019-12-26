FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV="b172fa10db70d01b3f9626209decd8b10e6aafd0"
SRC_URI += "file://hs9216.cfg \
            file://aspeed-bmc-hyve-hs9216.dts;subdir=git/arch/arm/boot/dts \
            file://0001-increase-rofs-space.patch \
            file://0002-Add-SGPIO-support.patch \
            file://0003-setting-lan-led-config.patch \
            file://0004-Fix-lan-issue-and-add-ncsi-speed-status.patch \
            file://0005-Add-I2C-IPMB-Support.patch \
           "
