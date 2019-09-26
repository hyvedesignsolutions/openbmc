#!/bin/sh
# Toggle the state of lamp_test LED Group

SERVICE="xyz.openbmc_project.LED.GroupManager"
INTERFACE="xyz.openbmc_project.Led.Group"
PROPERTY="Asserted"

# Get current state
object=$(busctl tree $SERVICE --list | grep lamp_test)
state=$(busctl get-property $SERVICE $object $INTERFACE $PROPERTY \
	  |  awk '{print $NF;}')

if [ "$state" == "false" ]; then
    target='true'
else
    target='false'
fi

# Set target state
busctl set-property $SERVICE $object $INTERFACE $PROPERTY b $target
