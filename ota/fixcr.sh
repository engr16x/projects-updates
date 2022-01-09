#!/bin/bash

# updates all of the files on the raspberry pi 
# in the update files folder to
# ensure that they have proper LF line endings 
# instead of the default CR LF line endings
# last updated 1/5/2022 by Trevor Ladner

echo
echo Correcting line endings
echo

sudo sed -i 's/\r$//' /home/pi/Desktop/source_files/plane.sh
sudo sed -i 's/\r$//' /home/pi/Desktop/source_files/boat.sh
sudo sed -i 's/\r$//' /home/pi/Desktop/source_files/donut.sh
sudo sed -i 's/\r$//' /home/pi/Desktop/source_files/elephant.sh
sudo sed -i 's/\r$//' /home/pi/Desktop/source_files/duck.sh

echo
echo line endings have been updated
echo

read -p 'Press Enter' -n 1 -s