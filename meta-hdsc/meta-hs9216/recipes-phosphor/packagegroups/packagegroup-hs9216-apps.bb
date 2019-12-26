SUMMARY = "OpenBMC for HDSC - Applications"
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HDSCBASE}/COPYING.apache-2.0;md5=1dece7821bf3fd70fe1309eaa37d52a2"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-chassis \
        ${PN}-fans \
        ${PN}-flash \
        ${PN}-system \
        ${PN}-host \
        "

PROVIDES += "virtual/obmc-chassis-mgmt"
#PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"
PROVIDES += "virtual/obmc-host-ctl"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
#RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"
RPROVIDES_${PN}-host += "virtual-obmc-host-ctl"


SUMMARY_${PN}-chassis = "HDSC Chassis"
RDEPENDS_${PN}-chassis = " \
        obmc-control-chassis \
        obmc-op-control-power \
        obmc-host-failure-reboots \
        "

#SUMMARY_${PN}-fans = "HDSC Fans"
#RDEPENDS_${PN}-fans = " \
#        phosphor-pid-control \
#        "

SUMMARY_${PN}-flash = "HDSC Flash"
RDEPENDS_${PN}-flash = " \
        obmc-flash-bmc \
        obmc-mgr-download \
        obmc-control-bmc \
        "

SUMMARY_${PN}-system = "HDSC System"
RDEPENDS_${PN}-system = " \
        systemd-analyze \
        bmcweb \
        phosphor-webui \
        entity-manager \
        intel-ipmi-oem \
        dbus-sensors \
        "
