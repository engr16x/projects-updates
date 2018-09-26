#!/bin/bash

echo
echo "Updating the GrovePi Firmware"
echo

sudo chmod +x /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh
cd /home/pi/Dexter/GrovePi/Firmware
sudo /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh

echo "Seas the day."
read temp
