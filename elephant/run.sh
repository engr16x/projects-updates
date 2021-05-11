#!/bin/bash

# Short program that assigns a new WiFi channel to
# the Raspberry Pi. Then new channel number is 
# chosen randomly between 1, 6, and 11, replacing 
# the old channel number that was previously in hostapd.conf
# This aims to solve latency issues with remote desktop during
# project demos when many pis are operating on the same default
# WiFi channel. 
# Written by David Li 10/5/2020

VCHECK=`cat /etc/motd | grep "6\."`
if [ "$VCHECK" != "" ]
then
    echo "THIS SCRIPT WAS WRITTEN FOR VERSION 5 ENGR OS BUILDS"
    echo "YOU ARE RUNNING VERSION: 6"
    echo "THIS SCRIPT WILL FAIL!"
    echo
    echo "Press [enter] to exit."
    read temp
    exit 0
fi

echo "Welcome to the ENGR16X WiFi channel update!"
echo "This script will reconfigure your Raspberry Pi's"
echo "access point channel number to channels 1, 6, or 11."
echo
runv1=0
runv2=0
while [[ $runv1 == 0 ]]; do
    read -p "Do you wish to run the channel update script? (y/n) " yn
    case $yn in
        [Yy]* ) runv1=1; runv2=1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [[ $runv2 == 1 ]];
    then
    echo
    echo "Reconfiguring network channels..."
    echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    random=$RANDOM
    channels=(1 6 11)
    let "randomIdx = random % 3"
    let "c = channels[randomIdx]"
    echo "Setting new channel to:" $c
    echo
    echo "Updating hostapd.conf:"
    echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    cd /etc/hostapd
    sudo sed 's/channel=.*/channel='$c'/g' hostapd.conf
    sudo sed -i 's/channel=.*/channel='$c'/g' hostapd.conf
    echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    echo "Updated channel successfully!"
    echo
fi

echo "Type ctrl-c to terminate this script."
echo "Then enter 'sudo reboot' to finish updating settings."
echo
echo "Always keep your trunks on."
read temp
