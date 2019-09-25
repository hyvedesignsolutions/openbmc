# RunBMC HS2500 Quick Start Guide
RunBMC HS2500 is an OCP project that use OpenBMC as it's internal BMC management firmware.
This quick start guide will teach you how to do basic function test within BMC console.

## BCM Console Login
Connect the micro usb uart5 to your host PC, it will show up a new serial device to you PC.
Use any terminal emulator program such as 'putty' or 'minicom' to connect this serial device with baud rate 115200.
You will see the login prompt for openbmc console :

```
Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 hs2500 ttyS4

hs2500 login: 
```
By default the login is 'root', password is '0penBmc'

```
Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 hs2500 ttyS4

hs2500 login: root
Password: 0penBmc 
root@hs2500:~# 
```

## Set MAC address
HS2500 has no default MAC address. You can set it manually. When there is no MAC address saved, openbmc will generate a random address every time.

```
fw_setenv ethaddr xx:xx:xx:xx:xx:xx
fw_setenv eth1addr xx:xx:xx:xx:xx:xx
reboot
```
After BMC reboot, the MAC address will apply.

## Get BMC network IP address
By default, BMC use DHCP to get IP address from DHCP server. The 'ip address' command will display all ip address.

```
root@hs2500:~# ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:11:22:33:44:77 brd ff:ff:ff:ff:ff:ff
    inet 169.254.233.135/16 brd 169.254.255.255 scope link eth0
       valid_lft forever preferred_lft forever
    inet 192.168.1.74/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 86374sec preferred_lft 86374sec
    inet6 fe80::211:22ff:fe33:4477/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:11:22:33:44:66 brd ff:ff:ff:ff:ff:ff
    inet 169.254.229.85/16 brd 169.254.255.255 scope link eth1
       valid_lft forever preferred_lft forever
    inet 192.168.1.57/24 brd 192.168.1.255 scope global dynamic eth1
       valid_lft 86373sec preferred_lft 86373sec
    inet6 fe80::211:22ff:fe33:4466/64 scope link 
       valid_lft forever preferred_lft forever
4: sit0@NONE: <NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
```

## BMC firmware update
BMC firmware can be updated if there is a file named 'image-bmc' in the /run/initramfs/ directory.
You can copy BMC firmware by scp command from your host.

```
export server=10.19.84.81
cd /run/initramfs/
scp user@{server}:image-bmc ./
reboot
```
During the BMC reboot process, the firmware will be updated.

## LED lamp_test
lamp_test will blink all 7 segments LEDs. It is useful to verify if all LEDs are workable.

```
busctl call `mapper get-service /xyz/openbmc_project/led/groups/lamp_test` \
/xyz/openbmc_project/led/groups/lamp_test org.freedesktop.DBus.Properties \
Set ssv xyz.openbmc_project.Led.Group Asserted b true
```

## Power, Reset and ID buttons
Before doing this test, connect J2002 pin #3 and pin #4 together by a jumper to let BMC sense correct power status.
There are 8 buttons on the HS2500, as described here:

| Button | Name | Action |
| ------ | ---- | ------ |
| SW703 | Power | Toggle host power on / off |
|       |       | Long press to force power off |
| SW702 | Reset | Toggle to reset host |
| SW701 | ID | Toggle to identify LED |


## I2C Device Detect
There are 12 I2C buses on the HS2500. The 'i2cdetect' can scan all available devices on a given i2c bus and display the slave address. For example, to detect devices on i2c10

```
root@hs2500:~# i2cdetect -y 10
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- 21 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- -- 
40: 40 41 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --
```

All available slave devices are described in this table.

| Bus Number | Slave Address | Device Name |
|------------|---------------|-------------|
| 0 | N/A | N/A |
| 1 | N/A | N/A |
| 2 | N/A | N/A |
| 3 | 50 | AT24C64D-SSHM-T |
| 4 | N/A | N/A |
| 5 | N/A | N/A |
| 6 | N/A | N/A |
| 7 | N/A | N/A |
| 8 | N/A | N/A |
| 9 | 20 | TPM SLB9645TT12FW13332XUMA1 |
| 10 | 21 | TCA9555 |
|   | 38 | PCA9554 |
|   | 40 | INA219AID |
|   | 41 | INA219AID |
| 11 | 48 | AT24C64D-SSHM-T |
|   | 70 | PCA9548 |

## Read ADC Voltage
There are 8 ADC channels on HS2500.
Channel 0 ~ 3 are connected to fixed voltage.
Channel 4 ~ 7 are adjustable by divider.
You can read ADC voltage from any channel. For example, to read voltage from ADC channel 2

```
root@hs2500:~# cat /sys/class/hwmon/hwmon1/in2_input 
1694
```

ADC Channel | Voltage | Accuracy|
------------|---------|---------|
in1_input | 1798 | +- 18|
in2_input | 1694 | +- 18|
in3_input | 1126 | +- 18|
in4_input | 833 | +- 18|
in5_input | 0 ~ 1798 | +- 18|
in6_input | 0 ~ 1798 | +- 18|
in7_input | 0 ~ 1798 | +- 18|
in8_input | 0 ~ 1798 | +- 18|

