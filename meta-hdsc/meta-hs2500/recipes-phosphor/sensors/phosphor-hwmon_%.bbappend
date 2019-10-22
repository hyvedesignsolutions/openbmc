FILESEXTRAPATHS_prepend_hs2500 := "${THISDIR}/${PN}:"

EXTRA_OECONF_append_hs2500 = " --enable-negative-errno-on-fail"

CHIPS = " \
        bus@1e78a000/i2c-bus@440/w83773g@4c \
        pwm-tacho-controller@1e786000 \
        "
ITEMSFMT = "ahb/apb/{0}.conf"

# ITEMS = "${@compose_list(d, 'ITEMSFMT', 'CHIPS')}"

ITEMS += "iio-hwmon-1_8v.conf \
         iio-hwmon-1_7v.conf \
         iio-hwmon-1_1v.conf \
         iio-hwmon-0_825v.conf \
         iio-hwmon-adc4.conf \
         iio-hwmon-adc5.conf \
         iio-hwmon-adc6.conf \
         iio-hwmon-adc7.conf \
         "

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_hs2500 = " ${@compose_list(d, 'ENVS', 'ITEMS')}"
