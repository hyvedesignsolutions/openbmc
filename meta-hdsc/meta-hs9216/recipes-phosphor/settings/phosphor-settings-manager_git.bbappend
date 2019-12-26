FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"
SRC_URI_append = " file://processor-state.override.yml \
                   file://acpi-state.override.yml \
                   file://acboot-state.override.yml \
                 "
