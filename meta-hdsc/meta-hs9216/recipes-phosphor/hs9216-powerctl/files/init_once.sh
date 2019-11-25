#!/bin/bash

# Set all output GPIOs as such and drive them with reasonable values.
echo "HS9216 power control init once script";

echo "Enable GPIOE0/E2 pass-through to GPIOE1/E3 function(Bit 12/13)";

mask=0x3000
/sbin/devmem 0x1e6e2000 32 0x1688A8A8
reg=$(/sbin/devmem 0x1e6e208c)
result=$((${reg} | ${mask}))
result_base16=$(printf "0x%x" $result)
/sbin/devmem 0x1e6e208c 32 $result_base16
/sbin/devmem 0x1e6e2000 32 0x00000001

echo "Display reg SCU80 value:" $(/sbin/devmem 0x1e6e208c);


exit 0;
