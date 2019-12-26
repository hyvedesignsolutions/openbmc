FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-Phy-reset-function-by-GPIOD5.patch \
            file://0002-MAC-addr-from-EEPROM.patch \
            file://0003-Hyve-init-process.patch \
            "

