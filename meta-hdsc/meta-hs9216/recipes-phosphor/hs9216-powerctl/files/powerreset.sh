/bin/bash

echo "Enter Power Reset System Action"

SERVICE="xyz.openbmc_project.Logging.IPMI"
OBJECT="/xyz/openbmc_project/Logging/IPMI"
INTERFACE="xyz.openbmc_project.Logging.IPMI"
METHOD="IpmiSelAdd"

pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 1 ]; then

    # *** Reset ***
    /usr/bin/gpioset gpiochip0 33=0
    sleep 1
    /usr/bin/gpioset gpiochip0 33=1

    busctl call $SERVICE $OBJECT $INTERFACE $METHOD ssaybq "SEL Entry" "/xyz/openbmc_project/sensors/systemboot/SYSTEM_RESTART" 3 {0x07,0xff,0xff} yes 0x20

else
    echo "System is off state."

fi

echo "Exit Power reset System action"
exit 0;
