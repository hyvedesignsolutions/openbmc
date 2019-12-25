SUMMARY = "Intel OEM IPMI commands"
DESCRIPTION = "Intel OEM IPMI commands"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a6a4edad4aed50f39a66d098d74b265b"

SRC_URI = "git://github.com/openbmc/intel-ipmi-oem \
           file://0001-hs9216-disable-Intel-OEM-command.patch \
           file://0002-hs9216-force-scanned-fru-from-ID1.patch \
           file://0003-Add-SDR-type-3-support.patch \
           file://0004-change-sel-to-non-volatile.patch \
           file://0005-add-sel-clear-event.patch \
           file://0006-Add-support-to-custom-sensor-number.patch \
           file://0007-add-ipmi-type.patch \        
           file://0008-Fix-ipmi-sel-get-issue.patch \ 
           file://0009-Handle-no-cachTimer-case-to-reduce-ipmi-command-respn.patch \
           "
SRCREV = "147daec5fcfcdacd8813eab6a7735d0f1b615c8a"

S = "${WORKDIR}/git"
PV = "0.1+git${SRCPV}"

DEPENDS = "boost phosphor-ipmi-host phosphor-logging systemd intel-dbus-interfaces"

inherit cmake obmc-phosphor-ipmiprovider-symlink

EXTRA_OECMAKE="-DENABLE_TEST=0 -DYOCTO=1"

#Enable custom sensor number
TARGET_CFLAGS += " -DCUSTOM_SENSORNUMBER"

LIBRARY_NAMES = "libzinteloemcmds.so"

HOSTIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"
NETIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/host-ipmid/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/net-ipmid/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV}"

do_install_append(){
       install -d ${D}${includedir}/intel-ipmi-oem
          install -m 0644 -D ${S}/include/*.hpp ${D}${includedir}/intel-ipmi-oem
 }
