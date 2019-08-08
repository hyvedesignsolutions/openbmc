FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"
SRC_URI_append_romulus = " file://romulus.cfg"

SRC_URI += "file://0001-Initial-device-tree-for-HS2500.patch"

