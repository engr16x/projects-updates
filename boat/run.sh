#!/bin/bash
# updates the grovepi firmware
# and updates the grovepi python library

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

sudo apt-get install libffi-dev

sudo chmod +x /home/pi/Dexter/GrovePi/Script/update_grovepi.sh
su - pi -c "/home/pi/Dexter/GrovePi/Script/update_grovepi.sh"

echo "copying new files to team account" 

file="/etc/passwd"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
  if [[ $f1 == *"team"* ]]; 
  then
    #echo "$f1 found"
    team=($f1)
  fi
done <"$file"

cp -rvu /home/pi/Dexter /home/$team/Desktop/Dexter

echo "Seas the day."
read temp
