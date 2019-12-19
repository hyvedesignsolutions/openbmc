#!/bin/bash


power_on_mask=0x2000

Control_PT_funtion(){
/sbin/devmem 0x1e6e2000 32 0x1688A8A8
reg=$(/sbin/devmem 0x1e6e208c)

if [ $1 == "disable" ]; then
   echo "Disable GPIO E2/E3 pass-through function (Bit 13)"
   result=$((${reg} & $((~${power_on_mask}))))
elif [ $1 == "enable" ]; then
   echo "Enable GPIO E2/E3 pass-through function (Bit 13)"
   result=$((${reg} | ${power_on_mask}))
fi

result_base16=$(printf "0x%x" $result)
/sbin/devmem 0x1e6e208c 32 $result_base16
#/sbin/devmem 0x1e6e208c 32 0x00001000
/sbin/devmem 0x1e6e2000 32 0x00000001
echo "Display reg SCU80 value:" $(/sbin/devmem 0x1e6e208c);
}

echo "Enter Power off System action"

pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 1 ]; then   

    Control_PT_funtion disable
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

    if [ -f "/var/tmp/poststart" ]; then
        rm /var/tmp/poststart
    fi


    Control_PT_funtion enable

fi

echo "Exit Power off System action"
exit 0;
