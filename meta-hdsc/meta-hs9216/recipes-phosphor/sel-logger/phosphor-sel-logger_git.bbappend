FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "6afe9560852c6431c43c8e79a28e2b7cb498e355"
SRC_URI += "file://0001-modifid-sel-to-non-volatile.patch \
          "

#Enable threshold monitoring
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"

