ALT_RMCPP_IFACE_hs9216  = "eth1"
SYSTEMD_SERVICE_${PN}_append_hs9216 += " \
    ${PN}@${ALT_RMCPP_IFACE}.service \
    ${PN}@${ALT_RMCPP_IFACE}.socket \
    "

