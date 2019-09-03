#!/bin/bash

echo "Enter Power on System action"

#USE GPIOS1 to check power status
pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 0 ]; then
    # *** Push power button ***
    # GPIO E3 for power on
    /usr/bin/gpioset gpiochip0 35=0
    sleep 1
    /usr/bin/gpioset gpiochip0 35=1 
    sleep 1
  
    #Monitor the PGood Status    
    CHECK=0
    while [ ${CHECK} -lt 10 ]
    do
        sleep 1
        pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
        if [ $pwrstatus -eq 1 ]; then
           busctl set-property xyz.openbmc_project.Watchdog /xyz/openbmc_project/watchdog/host0 xyz.openbmc_project.State.Watchdog Enabled b false
           if [ $? == 0 ]; then
               break;
           fi
        fi
        (( CHECK=CHECK+1 ))
    done
fi

echo "Exit Power on System action"
exit 0;
