#!/bin/bash

echo
echo "Updating the GrovePi Firmware"
echo

cd /home/pi/Dexter/GrovePi/

echo "Pulling newest version from Dexter's website"
sudo git fetch origin
sudo git reset --hard
sudo git merge origin/master

sudo chmod +x /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh
cd /home/pi/Dexter/GrovePi/Firmware
sudo /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh

echo "Seas the day."
read temp
