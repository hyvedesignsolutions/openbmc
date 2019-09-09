#Hyve install extra tool in image
OBMC_IMAGE_EXTRA_INSTALL_append_hs9216 = " ipmitool \
                                           ethtool  \
                                           gpio-initial \
                                           hs9216-powerctl \
                                           obmc-ikvm \
                                         "





