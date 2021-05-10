# quectel-CM-for-rpi
quectel-CM for RAK gateway LTE module (for RAK7244/RAK7243 or RAK2013/RAK8213+rpi4.).

##	Introduction 

This project is applicable to RAK's LTE module.
Help users to use RAK's LTE module more conveniently.
The LTE module and the Raspberry Pi need to be connected as follows.
![image](https://github.com/tvelev/quectel-CM-for-rpi/blob/master/lte_connect_rpi.jpg)

##	Supported platforms

Raspberry pi OS(buster) Raspbian.

##	Changelog
2020-05-27 V1.0.1
* 1.rak8213 support.

2020-03-26 V1.0.0
* 1.quectel support.

##	Installation procedure

step1 : Upgrade rpi OS.

      $ sudo apt update && sudo apt upgrade

step2 : Reboot raspberry pi, After restarting, use "uname -r" to confirm the kernel version is 4.19.xx.

step3 : Clone the installer and start the installation.

      $ git clone https://github.com/tvelev/quectel-CM-for-rpi.git ~/quectel-CM-for-rpi
      $ cd ~/quectel-CM-for-rpi
      $ sudo ./install.sh

step 4: If you want rak2013/rak8213 to dial automatically after the Raspberry Pi starts, please enter the "sudo systemctl enable qmi_connect.service" command after the installation is complete.

##	Other

When lte module dials successfully, all internet access will go through lte module.

You can view some other function descriptions in the advanced directory.
