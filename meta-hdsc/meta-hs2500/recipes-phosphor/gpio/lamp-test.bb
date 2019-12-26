SUMMARY = "HS2500 Lamp Test Button pressed application"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${IBMBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS_${PN} += "virtual/obmc-gpio-monitor"

S = "${WORKDIR}"
SRC_URI += "file://toggle_lamp_test.sh"

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/toggle_lamp_test.sh \
            ${D}${bindir}/toggle_lamp_test.sh
}

SYSTEMD_ENVIRONMENT_FILE_${PN} +="obmc/gpio/lamp_test_button"

LAMP_TEST_BUTTON_SERVICE = "lamp_test_button"

TMPL = "phosphor-gpio-monitor@.service"
INSTFMT = "phosphor-gpio-monitor@{0}.service"
TGT = "multi-user.target"
FMT = "../${TMPL}:${TGT}.wants/${INSTFMT}"

SYSTEMD_SERVICE_${PN} += "lamp-test-button-pressed.service"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT', 'LAMP_TEST_BUTTON_SERVICE')}"
