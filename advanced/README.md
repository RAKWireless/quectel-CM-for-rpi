# quectel-CM-for-rpi4 advanced

##	How to modify apn name 

Change the apn name by executing the "sudo ./modify_apn.sh 'your_apn_name'" command in the current directory.

##	Other

In the script /usr/local/rak/qmi/qmi_connect.sh, the default is to use ping 8.8.8.8 to determine whether the dialing is successful. If your area cannot ping 8.8.8.8, please replace 8.8.8.8 in the script with a public network address or domain name that you can ping.

