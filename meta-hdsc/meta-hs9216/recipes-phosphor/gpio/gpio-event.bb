SUMMARY = "CATEER Trigger application"
PR = "r1"

inherit obmc-phosphor-systemd
inherit autotools pkgconfig
inherit obmc-phosphor-ipmiprovider-symlink
inherit pythonnative
inherit systemd
inherit obmc-phosphor-systemd


LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HDSCBASE}/COPYING.apache-2.0;md5=1dece7821bf3fd70fe1309eaa37d52a2"

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS_${PN} += "virtual/obmc-gpio-monitor"

S = "${WORKDIR}"
SRC_URI += "file://bootstrap.sh \
            file://configure.ac \
            file://gpio_event.cpp \
            file://LICENSE \
            file://Makefile.am"

DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbusplus sdbusplus-native"
DEPENDS += "phosphor-logging"
DEPENDS += "phosphor-dbus-interfaces phosphor-dbus-interfaces-native"
DEPENDS += "sdbus++-native"
DEPENDS += "boost"

do_install() {
    install -d ${D}/usr/sbin
    install -m 0755 ${S}/build/gpio_event ${D}/${sbindir}/
}


SYSTEMD_SERVICE_${PN} = "xyz.openbmc_project.gpio-event@.service"




