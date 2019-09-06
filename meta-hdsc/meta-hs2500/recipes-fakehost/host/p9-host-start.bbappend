RDEPENDS_${PN}_remove_hs2500 = " avsbus-control \
                                 vrm-control \
                                 p9-vcs-workaround \
                                 op-proc-control \
                                 "
FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/op-host-control:"
