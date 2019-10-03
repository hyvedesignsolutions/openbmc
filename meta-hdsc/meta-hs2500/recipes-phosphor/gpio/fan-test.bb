SUMMARY = "HS2500 Fan Test Button pressed application"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS_${PN} += "virtual/obmc-gpio-monitor"

S = "${WORKDIR}"
SRC_URI += "file://toggle_fan_speed.sh"

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/toggle_fan_speed.sh \
            ${D}${bindir}/toggle_fan_speed.sh
}

SYSTEMD_ENVIRONMENT_FILE_${PN} +="obmc/gpio/fan_test_button"

FAN_TEST_BUTTON_SERVICE = "fan_test_button"

TMPL = "phosphor-gpio-monitor@.service"
INSTFMT = "phosphor-gpio-monitor@{0}.service"
TGT = "multi-user.target"
FMT = "../${TMPL}:${TGT}.wants/${INSTFMT}"

SYSTEMD_SERVICE_${PN} += "fan-test-button-pressed.service"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT', 'FAN_TEST_BUTTON_SERVICE')}"
