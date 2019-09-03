FILESEXTRAPATHS_append := "${THISDIR}/files:"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HDSCBASE}/COPYING.apache-2.0;md5=1dece7821bf3fd70fe1309eaa37d52a2"

inherit systemd
inherit obmc-phosphor-systemd

S = "${WORKDIR}/"

SRC_URI = "file://gpio-initial.sh \
           file://gpio-initial.service \
           "

DEPENDS = "systemd"
RDEPENDS_${PN} = "bash"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "gpio-initial.service"

do_install() {
    install -d ${D}/usr/sbin
    install -m 0755 ${S}gpio-initial.sh ${D}/${sbindir}/
}
