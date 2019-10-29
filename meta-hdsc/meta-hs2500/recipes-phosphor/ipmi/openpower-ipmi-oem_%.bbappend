DEPENDS_append_hs2500 = " hs2500-yaml-config"

EXTRA_OECONF_hs2500 = " \
    INVSENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/hs2500-yaml-config/ipmi-inventory-sensors.yaml \
    "
