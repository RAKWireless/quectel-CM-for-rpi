#!/bin/sh


cleanup_gpio()
{
    if [ -d /sys/class/gpio/gpio$1 ]
    then
        echo "$1" > /sys/class/gpio/unexport; sleep 0.2
    fi
}

cd /sys/class/gpio/
if [ ! -d /sys/class/gpio/gpio5 ]; then
    echo 5 > export
fi

if [ ! -d /sys/class/gpio/gpio6 ]; then
    echo 6 > export
fi

if [ ! -d /sys/class/gpio/gpio13 ]; then
    echo 13 > export
fi

if [ ! -d /sys/class/gpio/gpio19 ]; then
    echo 19 > export
fi

if [ ! -d /sys/class/gpio/gpio21 ]; then
    echo 21 > export
fi

if [ ! -d /sys/class/gpio/gpio26 ]; then
    echo 26 > export
fi


echo out > gpio5/direction
echo out > gpio6/direction
echo out > gpio13/direction
echo out > gpio19/direction
echo in > gpio21/direction
echo out > gpio26/direction

echo 0 > gpio5/value
echo 0 > gpio6/value
echo 0 > gpio13/value
echo 0 > gpio19/value
echo 0 > gpio26/value


#
cd /sys/class/gpio/

if [ ! -d /sys/class/gpio/gpio18 ]; then
    echo "18" > /sys/class/gpio/export
fi
echo "out" > /sys/class/gpio/gpio18/direction
echo 0 > /sys/class/gpio/gpio18/value
sleep 0.2
echo 1 > /sys/class/gpio/gpio18/value
sleep 0.2
echo 0 > /sys/class/gpio/gpio18/value
