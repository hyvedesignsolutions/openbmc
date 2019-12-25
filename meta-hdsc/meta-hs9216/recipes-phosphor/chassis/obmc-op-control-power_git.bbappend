FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

S = "${WORKDIR}/git/op-pwrctl/"
SRC_URI += "file://0001-make-pgood-servcie-don-t-stop-polling.patch"
