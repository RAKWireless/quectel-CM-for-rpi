#!/bin/bash

echo "rak_qmi version: 1.0.1"
cd /usr/local/rak/qmi

while true; do
    if [[ `grep "wwan0" /proc/net/dev` == "" ]]; then
        ./active_lte_module.sh
        sleep 15
        continue
    else
        break
    fi
done

ping_cnt_failure=0

while true; do

    ret=`ps -ef|grep quectel-CM|grep -v grep|wc -l`
    if [ "$ret" = "1" ]; then
        ping -c 1 8.8.8.8
        if [ $? -eq 0 ]; then
            echo "ping 8.8.8.8 normal ok, continue."
            sleep 600
            continue
        else
            let ping_cnt_failure=ping_cnt_failure+1
            echo "ping 8.8.8.8 normal failure, ping_cnt_failure:$ping_cnt_failure."
            if [ $ping_cnt_failure -gt 5 ]; then
                sleep 20
                break
            fi
        fi
        ping -I wwan0 -c 1 8.8.8.8
        if [ $? -eq 0 ]; then
            echo "ping 8.8.8.8 via wwan0 ok, add default wwan0..."
            route del default
            route add default dev wwan0
            let ping_cnt_failure=0
            continue
        fi
    else
        ./quectel-CM -s #APN &
    fi

    sleep 30
done

echo "exit qmi_connect.sh"
killall -9 quectel-CM
