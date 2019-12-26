FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"
SRC_URI += "file://obmc-disable-host-watchdog@.service"

DISABLE_WATCHDOG_TMPL = "obmc-disable-host-watchdog@.service"
SYSTEMD_SERVICE_${PN} += "${DISABLE_WATCHDOG_TMPL}"

DISABLE_WATCHDOG_TGTFMT = "obmc-disable-host-watchdog@{0}.service"
DISABLE_WATCHDOG_FMT = "../${DISABLE_WATCHDOG_TMPL}:obmc-host-start@{0}.target.wants/${DISABLE_WATCHDOG_TGTFMT}"

SYSTEMD_LINK_${PN} += "${@compose_list(d, 'DISABLE_WATCHDOG_FMT', 'OBMC_HOST_INSTANCES')}"
