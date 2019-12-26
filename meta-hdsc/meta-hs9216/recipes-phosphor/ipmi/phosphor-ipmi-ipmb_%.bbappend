FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://ipmb-channels.json"

SRCREV = "bbfd00abdbc6d2f7c0389eae91cc055a1d4fe0c3"
do_install_append(){
    install -m 0644 -D ${WORKDIR}/ipmb-channels.json \
                   ${D}/usr/share/ipmbbridge
}
