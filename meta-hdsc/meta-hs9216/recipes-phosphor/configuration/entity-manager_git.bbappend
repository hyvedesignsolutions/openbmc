FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "155362c341036b528326da2b58067f1f6125e922"

SRC_URI += "file://0001-workaround-fix-for-fru.patch \
            file://hs9216-MB.json \
            "

SRC_URI += "file://*.json"

do_install_append(){
	install -d ${D}/usr/share/entity-manager/configurations
	install -m 0444 ${WORKDIR}/*.json ${D}/usr/share/entity-manager/configurations
}
