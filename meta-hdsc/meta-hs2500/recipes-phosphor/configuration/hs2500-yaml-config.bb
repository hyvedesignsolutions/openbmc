SUMMARY = "YAML configuration for HS2500"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit allarch

SRC_URI = " \
    file://hs2500-ipmi-fru.yaml \
    file://hs2500-ipmi-fru-bmc.yaml \
    file://hs2500-ipmi-fru-properties.yaml \
    file://hs2500-ipmi-inventory-sensors.yaml \
    file://hs2500-ipmi-sensors.yaml \
    "

S = "${WORKDIR}"

do_install() {
    cat hs2500-ipmi-fru.yaml hs2500-ipmi-fru-bmc.yaml > fru-read.yaml

    install -m 0644 -D hs2500-ipmi-fru-properties.yaml \
        ${D}${datadir}/${BPN}/ipmi-extra-properties.yaml
    install -m 0644 -D fru-read.yaml \
        ${D}${datadir}/${BPN}/ipmi-fru-read.yaml
    install -m 0644 -D hs2500-ipmi-inventory-sensors.yaml \
        ${D}${datadir}/${BPN}/ipmi-inventory-sensors.yaml
    install -m 0644 -D hs2500-ipmi-sensors.yaml \
        ${D}${datadir}/${BPN}/ipmi-sensors.yaml
}

FILES_${PN}-dev = " \
    ${datadir}/${BPN}/ipmi-extra-properties.yaml \
    ${datadir}/${BPN}/ipmi-fru-read.yaml \
    ${datadir}/${BPN}/ipmi-inventory-sensors.yaml \
    ${datadir}/${BPN}/ipmi-sensors.yaml \
    "

ALLOW_EMPTY_${PN} = "1"
