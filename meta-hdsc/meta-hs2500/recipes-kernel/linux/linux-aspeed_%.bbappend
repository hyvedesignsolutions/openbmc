FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"
SRC_URI_append_romulus = " file://romulus.cfg"

SRC_URI += "file://0001-Initial-device-tree-for-HS2500.patch \
            file://0002-ARM-dts-aspeed-hs2500-Enable-MAC0-and-MAC1.patch \
            file://0003-ARM-dts-aspeed-hs2500-Enable-support-for-SEG701-LED.patch \
            "
