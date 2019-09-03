#!/bin/bash

echo "Enter Power off System action"

pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 1 ]; then   
    # *** Push power button ***
    # GPIO E1
    /usr/bin/gpioset gpiochip0 35=0
    for (( i=0; i<=6; i=i+1 ))
    do
        sleep 1
        pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
        if [ $pwrstatus -eq 0 ]; then
             break;    
        fi
    done    
    /usr/bin/gpioset gpiochip0 35=1
    sleep 1
    obmcutil chassisoff 
fi

echo "Exit Power off System action"
exit 0;
