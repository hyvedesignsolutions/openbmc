FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-modfiied-fan-MaxReading.patch \
            file://0002-modified-psusensor.patch \
            file://0003-add-new-processor-sensor-to-replace-gpio-sensor.patch \
            "

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.processorsensor.service"
