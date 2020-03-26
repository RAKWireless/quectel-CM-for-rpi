#!/bin/bash

: '
QMI installation script by Sixfab

Created By Metin Koc, Nov 2018
Modified by Saeed Johar, 11th June 2019
'

if [ $UID != 0 ]; then
    echo_error "Operation not permitted. Forgot sudo?"
    exit 1
fi

echo -e "\033[1;33m Input APN name:\033[0m"
#echo "What is the APN?"
read carrierapn

apt update -y
set -e
apt-get install raspberrypi-kernel-headers -y

echo -e "\033[1;33mClear Files$\033[0m"
rm -rf /tmp/files
rm -rf /tmp/files.zip
mkdir /tmp/files/
unzip quectel-CM.zip -d /tmp/files/ 

echo -e "\033[1;33m Checking Kernel\033[0m"
case $(uname -r) in
    4.19*) echo $(uname -r) based kernel found 
        unzip drivers.zip -d /tmp/files/ ;;
    *) echo "Driver for $(uname -r) kernel not found";exit 1;

esac

apt-get install udhcpc -y

mkdir -p /usr/share/udhcpc
cp /tmp/files/quectel-CM/default.script /usr/share/udhcpc/
chmod +x /usr/share/udhcpc/default.script

echo -e "\033[1;33m Change directory to /tmp/files/drivers\033[0m"
pushd /tmp/files/drivers
make && make install
popd

echo -e "\033[1;33m Change directory to /tmp/files/quectel-CM\033[0m"
pushd /tmp/files/quectel-CM
make
popd

mkdir -p /usr/local/rak/qmi/
cp /tmp/files/quectel-CM/quectel-CM /usr/local/rak/qmi/ -f
cp /tmp/files/quectel-CM/quectel-qmi-proxy /usr/local/rak/qmi/ -f

cp qmi_connect.sh /usr/local/rak/qmi/
cp active_lte_module.sh /usr/local/rak/qmi/
cp qmi_connect.service /etc/systemd/system/

sed -i "s/#APN/$carrierapn/" /usr/local/rak/qmi/qmi_connect.sh

#systemctl enable qmi_connect.service

echo -e "\033[1;33m If you want to set it to dial automatically after the operating system starts, please run the \"sudo systemctl enable qmi_connect.service\" command and restart rpi.\033[0m"
