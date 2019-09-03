#!/bin/bash

echo "Enter Power Reset System Action"

pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 1 ]; then

    # *** Reset ***
    /usr/bin/gpioset gpiochip0 33=0
    sleep 1
    /usr/bin/gpioset gpiochip0 33=1
else
    echo "System is off state."

fi

echo "Exit Power reset System action"
exit 0;
