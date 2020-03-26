# quectel-CM-for-rpi4
quectel-CM for RAK gateway LTE module (for RAK7244 or RAK2013+rpi4. Rpi3 and lower are not supported).

##	Introduction 

This project is applicable to RAK's LTE module.
Help users to use RAK's LTE module more conveniently.
The LTE module and the Raspberry Pi need to be connected as follows.
![image](https://github.com/RAKWireless/quectel-CM-for-rpi4/blob/master/img/lte_connect_rpi.jpg)

##	Supported platforms

Raspberry pi OS(buster) Raspbian.

##	Changelog
2020-03-26 V1.0.0
* 1.quectel support.

##	Installation procedure

step1 : Clone the installer and start the installation.

      $ sudo apt update && sudo apt upgrade

step2 : Reboot raspberry pi, After restarting, use "uname -r" to confirm the kernel version is 4.19.xx.

step3 : Clone the installer and start the installation.

      $ git clone https://github.com/RAKWireless/quectel-CM-for-rpi4.git ~/quectel-CM-for-rpi4
      $ cd ~/quectel-CM-for-rpi4
      $ sudo ./install.sh

step 4: If you want rak2013 to dial automatically after the Raspberry Pi starts, please enter the "sudo systemctl enable qmi_connect.service" command after the installation is complete.

##	Other

When rak2013 dials successfully, all internet access will go through rak2013.

You can view some other function descriptions in the advanced directory.
