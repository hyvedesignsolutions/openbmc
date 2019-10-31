SRCREV = "2adc95cb4d9ac879f66aa9ef12a6ce8b7c1578fe"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-modfiied-fan-MaxReading.patch \
            file://0002-modified-psusensor.patch \
            file://0003-add-new-processor-sensor-to-replace-gpio-sensor.patch \
            file://0004-add-ipmi-ACPI-sensor.patch \
            file://0005-Add-aclost-detect-sensor.patch \
            file://0006-Add-SDR-only-sensor.patch \
            "

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.processorsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.acpisensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.powersupplysensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.sdronlysensor.service"
