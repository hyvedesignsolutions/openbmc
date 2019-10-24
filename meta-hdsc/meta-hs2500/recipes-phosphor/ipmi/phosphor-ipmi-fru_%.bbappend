DEPENDS_append_hs2500 = " hs2500-yaml-config"

EXTRA_OECONF_romulus = " \
    YAML_GEN=${STAGING_DIR_HOST}${datadir}/hs2500-yaml-config/ipmi-fru-read.yaml \
    PROP_YAML=${STAGING_DIR_HOST}${datadir}/hs2500-yaml-config/ipmi-extra-properties.yaml \
    "
