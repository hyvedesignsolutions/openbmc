LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HDSCBASE}/COPYING.apache-2.0;md5=1dece7821bf3fd70fe1309eaa37d52a2"

inherit systemd
inherit obmc-phosphor-systemd

S = "${WORKDIR}/"

SRC_URI = "file://init_once.sh \
           file://poweroff.sh \
           file://poweron.sh \
           file://powerreset.sh \
           file://host-gpio.service \
           file://host-poweroff.service \
           file://host-poweron.service \
           file://host-powerreset.service"

DEPENDS = "systemd"
RDEPENDS_${PN} = "bash"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "host-gpio.service host-poweron.service host-poweroff.service host-powerreset.service"

do_install() {
    install -d ${D}/usr/sbin
    install -m 0755 ${S}init_once.sh ${D}/${sbindir}/
    install -m 0755 ${S}poweroff.sh ${D}/${sbindir}/
    install -m 0755 ${S}poweron.sh ${D}/${sbindir}/
    install -m 0755 ${S}powerreset.sh ${D}/${sbindir}/
}
