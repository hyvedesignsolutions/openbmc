FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-interface-for-caterr-logging.patch \
            file://0002-Add-interface-for-acboot.patch \
            file://0003-Add-warm-reset-property.patch \
           "

