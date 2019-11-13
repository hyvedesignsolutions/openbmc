FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit meson pkgconfig

DEPENDS += "libgpiod boost cli11 nlohmann-json"
SRCREV = "d34bd96c262cd326583acba76a651426f24a35ae"

SRC_URI += "file://phosphor-gpio-monitor@.service \
            file://phosphor-multi-gpio-monitor.service \
            file://phosphor-multi-gpio-monitor.json \
            file://0001-modify-mesonbuild-file-to-fix-build-error.patch" 

SRC_URI += "file://*.json"

SYSTEMD_SERVICE_${PN}-monitor += "phosphor-multi-gpio-monitor.service"
FILES_${PN}-monitor += "${bindir}/phosphor-multi-gpio-monitor"
FILES_${PN}-monitor += "${datadir}/phosphor-gpio-monitor/phosphor-multi-gpio-monitor.json"


do_install_append(){
        install -d ${D}/usr/share/phosphor-gpio-monitor
        install -m 0444 ${WORKDIR}/*.json ${D}/usr/share/phosphor-gpio-monitor/phosphor-multi-gpio-monitor.json
}

