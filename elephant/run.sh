#!/bin/bash

echo
echo "Updating network channels..."
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

random=$RANDOM
channels=(1 6 11)

let "randomIdx = random % 3"
let "c = channels[randomIdx]"

echo "Setting new channel to:" $c
echo
echo "Updated hostapd.conf:"
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
cd /etc/hostapd
sudo sed 's/channel=.*/channel='$c'/g' hostapd.conf
echo 
echo "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
echo "Updated channel successfully! Press Ctrl-C to exist..."
echo

echo "Always keep your trunks on."
read temp
