#!/bin/bash

echo
echo "Changing WiFi name"
sudo python3 /home/pi/Desktop/source_files/plane/plane/SSID_fix.py
read -p 'Press Enter' -n 1 -s