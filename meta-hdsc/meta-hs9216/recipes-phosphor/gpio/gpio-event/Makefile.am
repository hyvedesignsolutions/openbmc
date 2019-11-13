sbin_PROGRAMS = gpio_event

gpio_event_SOURCES = gpio_event.cpp 
gpio_event_LDFLAGS = $(SYSTEMD_LIBS) \
                      $(SDBUSPLUS_LIBS)
gpio_event_CFLAGS = $(SYSTEMD_CFLAGS) \
                     $(SDBUSPLUS_CFLAGS)

