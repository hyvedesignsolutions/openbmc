#!/bin/bash

service="xyz.openbmc_project.Settings"
acinterface="xyz.openbmc_project.Common.ACBoot"
acobject="/xyz/openbmc_project/control/host0/ac_boot"
acproperty="ACBoot"

acpiinterface="xyz.openbmc_project.Control.Power.ACPIPowerState"
acpiobject="/xyz/openbmc_project/control/host0/acpi_power_state"
acpiproperty1="DevACPIStatus"
acpiproperty2="SysACPIStatus"

mapper wait /xyz/openbmc_project/sensors/powersupply/ACLost
mapper wait /xyz/openbmc_project/control/host0/acpi_power_state

checkfun=`devmem 0x1e6e203c`
acbootCheck=`echo $((checkfun))`
echo "acbootCheck=$acbootCheck"

#check if value=0x11
if [[ "$acbootCheck" -eq "17" ]]; then
    echo "AC REBOOT"
    #clear ac state before check
    busctl set-property $service $acobject $acinterface $acproperty "s" "Unknown"
    busctl set-property $service $acpiobject $acpiinterface $acpiproperty1 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.Unknown"
    busctl set-property $service $acpiobject $acpiinterface $acpiproperty2 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.Unknown"
    if [ -f "/var/ipmi_sel" ]; then
        checkS5=`cat /var/ipmi_sel | grep ACPI_POWER_STATE | awk -F ',' 'END{print $3}'`
        if [ "${checkS5:0:2}" == "00" ]; then
            #fix last S5 not record problem.
            busctl set-property $service $acpiobject $acpiinterface $acpiproperty1 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.S5_G2"
            busctl set-property $service $acpiobject $acpiinterface $acpiproperty2 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.S5_G2"
        fi
    fi
    busctl set-property $service $acobject $acinterface $acproperty "s" "True"
    #check pgood
    pgood=`busctl get-property org.openbmc.control.Power /org/openbmc/control/power0 org.openbmc.control.Power pgood | awk '{print $2}'`
    if [ "$pgood" == "1" ]; then
        busctl set-property $service $acpiobject $acpiinterface $acpiproperty1 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.S0_G0_D0"
        busctl set-property $service $acpiobject $acpiinterface $acpiproperty2 "s" "xyz.openbmc_project.Control.Power.ACPIPowerState.ACPI.S0_G0_D0"
    fi
else
    echo "not in AC REBOOT state"
    busctl set-property $service $acobject $acinterface $acproperty "s" "False"
fi

