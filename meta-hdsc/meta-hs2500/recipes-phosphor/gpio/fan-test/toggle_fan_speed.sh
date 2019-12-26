#!/bin/sh
# Toggle fan speed between 50% and 100% duty cycle.

FAN1PWMPATH="/sys/class/hwmon/hwmon0/pwm1"
FAN2PWMPATH="/sys/class/hwmon/hwmon0/pwm2"
FAN3PWMPATH="/sys/class/hwmon/hwmon0/pwm3"
FAN4PWMPATH="/sys/class/hwmon/hwmon0/pwm4"

fan1pwm=$(cat /sys/class/hwmon/hwmon0/pwm1)
fan2pwm=$(cat /sys/class/hwmon/hwmon0/pwm2)
fan3pwm=$(cat /sys/class/hwmon/hwmon0/pwm3)
fan4pwm=$(cat /sys/class/hwmon/hwmon0/pwm4)

if [ "$fan1pwm" -eq "255" ]; then
    duty1=127
else
    duty1=255
fi

if [ "$fan2pwm" -eq "255" ]; then
    duty2=127
else
    duty2=255
fi

if [ "$fan3pwm" -eq "255" ]; then
    duty3=127
else
    duty3=255
fi

if [ "$fan4pwm" -eq "255" ]; then
    duty4=127
else
    duty4=255
fi

# Set pwm duty
echo $duty1 > $FAN1PWMPATH
echo $duty2 > $FAN2PWMPATH
echo $duty3 > $FAN3PWMPATH
echo $duty4 > $FAN4PWMPATH
