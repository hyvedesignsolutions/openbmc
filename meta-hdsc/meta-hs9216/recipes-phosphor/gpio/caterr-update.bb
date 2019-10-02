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
            file://caterr_update.cpp \
            file://LICENSE \
            file://Makefile.am \
            file://xyz.openbmc_project.caterr-update@.service"

DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbusplus sdbusplus-native"
DEPENDS += "phosphor-logging"
DEPENDS += "phosphor-dbus-interfaces phosphor-dbus-interfaces-native"
DEPENDS += "sdbus++-native"

do_install() {
    install -d ${D}/usr/sbin
    install -m 0755 ${S}/build/caterr_update ${D}/${sbindir}/
}

SYSTEMD_ENVIRONMENT_FILE_${PN} +="obmc/gpio/caterr_assert \
                                  obmc/gpio/caterr_deassert"

CATERR_UPDATE_SERVICE = "caterr_assert caterr_deassert"

TMPL = "phosphor-gpio-monitor@.service"
INSTFMT = "phosphor-gpio-monitor@{0}.service"
TGT = "${SYSTEMD_DEFAULT_TARGET}"
FMT = "../${TMPL}:${TGT}.requires/${INSTFMT}"

CATERR_SERVICE_FMT = "xyz.openbmc_project.caterr-update@{0}.service"
SYSTEMD_SERVICE_${PN} += "${@compose_list(d, 'CATERR_SERVICE_FMT', 'CATERR_UPDATE_SERVICE')}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT', 'CATERR_UPDATE_SERVICE')}"



