/bin/bash


E0_mask=0x1000

Control_PT_funtion(){
/sbin/devmem 0x1e6e2000 32 0x1688A8A8
reg=$(/sbin/devmem 0x1e6e208c)

if [ $1 == "disable" ]; then
   echo "Disable GPIO E0/E1 pass-through function (Bit 12)"
   result=$((${reg} & $((~${E0_mask}))))
elif [ $1 == "enable" ]; then
   echo "Enable GPIO E0/E1 pass-through function (Bit 12)"
   result=$((${reg} | ${E0_mask}))
fi

result_base16=$(printf "0x%x" $result)
/sbin/devmem 0x1e6e208c 32 $result_base16
#/sbin/devmem 0x1e6e208c 32 0x00001000
/sbin/devmem 0x1e6e2000 32 0x00000001
echo "Display reg SCU80 value:" $(/sbin/devmem 0x1e6e208c);
}

echo "Enter Power Reset System Action"

SERVICE="xyz.openbmc_project.Logging.IPMI"
OBJECT="/xyz/openbmc_project/Logging/IPMI"
INTERFACE="xyz.openbmc_project.Logging.IPMI"
METHOD="IpmiSelAdd"

pwrstatus=$(/usr/bin/gpioget gpiochip0 145)
if [ $pwrstatus -eq 1 ]; then

    Control_PT_funtion disable

    # *** Reset ***
    /usr/bin/gpioset gpiochip0 33=0
    sleep 1
    /usr/bin/gpioset gpiochip0 33=1

    busctl call $SERVICE $OBJECT $INTERFACE $METHOD ssaybq "SEL Entry" "/xyz/openbmc_project/sensors/systemboot/SYSTEM_RESTART" 3 {0x07,0xff,0xff} yes 0x20

    Control_PT_funtion enalbe
else
    echo "System is off state."

fi

echo "Exit Power reset System action"
exit 0;
