#!/bin/bash

# updates the grovepi firmware
# and updates the grovepi python library
# edited 10/17/2020

echo
echo "Updating the GrovePi Firmware"
echo


runv1=0
runv2=0
while [[ $runv1 == 0 ]]; do
    read -p "Do you need to update the firmware (y/n) " yn
    case $yn in
        [Yy]* ) runv1=1; runv2=1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

runv3=0
runv4=0
while [[ $runv3 == 0 ]]; do
    read -p "Do you need to update the Python libraries (y/n) " yn
    case $yn in
        [Yy]* ) runv3=1; runv4=1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


cd /home/pi/Dexter/GrovePi

echo "Pulling newest code from Dexter's website"
sudo git fetch origin
sudo git reset --hard
sudo git merge origin/master

echo
echo "copying new files to team account" 
echo
file="/etc/passwd"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
  if [[ $f1 == *"team"* ]]; 
  then
    #echo "$f1 found"
    team=($f1)
  fi
done <"$file"

sudo rm -rf /home/$team/Desktop/Dexter/GrovePi
sudo cp -r /home/pi/Dexter/GrovePi /home/$team/Desktop/Dexter/GrovePi


if [[ $runv2 == 1 ]];
    # only update the firmware
    then

    sudo chmod +x /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh
    cd /home/pi/Dexter/GrovePi/Firmware
    sudo /home/pi/Dexter/GrovePi/Firmware/firmware_update.sh
fi



if [[ $runv4 == 1 ]];
    then
    cd /home/pi/Dexter
    
    git clone https://github.com/DexterInd/RFR_Tools.git
    sudo cp /home/pi/Desktop/updates/boat/boat/setup_mod.py /home/pi/Dexter/RFR_Tools/miscellaneous/setup_mod.py
    cd /home/pi/Dexter/RFR_Tools/miscellaneous
    sudo python setup_mod.py install
    sudo adduser $team gpio
fi

echo "Seas the day. (press any button to exit)"
read temp
