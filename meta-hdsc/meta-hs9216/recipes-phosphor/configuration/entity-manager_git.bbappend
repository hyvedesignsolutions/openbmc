FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/openbmc/entity-manager.git \
           file://0001-Support-16-bit-FRU-and-workaround-fix-for-pad-error.patch \
           "
SRCREV = "c296c80e47ac348a61b5220f9476d7bcd34c546f"

SRC_URI += "file://hs9216-MB.json \
            "

SRC_URI += "file://*.json"

do_install_append(){
	install -d ${D}/usr/share/entity-manager/configurations
	install -m 0444 ${WORKDIR}/*.json ${D}/usr/share/entity-manager/configurations
}
