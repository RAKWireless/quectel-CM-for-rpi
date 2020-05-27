#!/bin/bash

set -e

if [ $UID != 0 ]; then
    echo "Operation not permitted. Forgot sudo?"
    exit 1
fi

if [ ! -f /usr/local/rak/qmi/qmi_connect.sh ]; then
    echo "Please confirm that you have quectel-CM-for-rpi installed?"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "The correct command format is:" 
    echo "      sudo ./modify_apn.sh \"your_apn_name\"."
    exit 1
fi

cp ../qmi_connect.sh /usr/local/rak/qmi/qmi_connect.sh
sed -i "s/#APN/$1/" /usr/local/rak/qmi/qmi_connect.sh
