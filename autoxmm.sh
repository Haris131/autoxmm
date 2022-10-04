#!/bin/bash
# Auto Change IP Fibocom L860
# https://github.com/Haris131/autoxmm
# https://fb.me/hrs.chjporo
clear

timer() {
for (( c="${1}"; c>=1; c-- ))
do
 printf "%s\rwaiting ${c} seconds"
 sleep 1
 printf "%s\r                                    \r"
done
}

reset_usb() {
  GPIO="/sys/class/gpio"
  pin_usb="505"
  # initialize gpio
  echo "${pin_usb}" > "${GPIO}/export"
  echo out > "${GPIO}/gpio${pin_usb}/direction"
  echo 0 > "${GPIO}/gpio${pin_usb}/value"
  sleep 1
  echo 1 > "${GPIO}/gpio${pin_usb}/value"
}

while true; do
  clear
  list="internet;aha;www.xl4g.net"
  c=0
  while [[ $c -le $(echo $list|awk -F ";" '{print NF-1}') ]]; do
    clear
    if [ $(logread|grep 'IntelNCM: Connection established'|head -n1|cut -d' ' -f10) ]; then
      ipfound=$(logread|grep 'IntelNCM: Obtain address'|head -n1|cut -d' ' -f 11)
      apn=$(grep "apn" /etc/config/xmm-modem|cut -d"'" -f2)
      echo -e "APN: $apn"
      echo -e "Obtain Address: $ipfound"
      exit
    fi
    apn=$(echo $list|awk -F ";" -v x=$(($c+1)) '{print $x}')
    find=$(grep "apn" /etc/config/xmm-modem|cut -d"'" -f2)
    sed -i "s/$find/$apn/g" /etc/config/xmm-modem
    sleep 1
    reset_usb
    timer 60
  ((c++))
  done
done
