#!/bin/bash

echo
echo "Fixing SPI"
echo

sudo raspi-config nonint do_spi 1
sudo raspi-config nonint do_spi 0

read -p 'Press Enter' -n 1 -s