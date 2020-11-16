#!/bin/bash

# updates the grovepi firmware
# edit 10/17/2020
# and updates the grovepi python library
# edit 11/12/2020
# removes offending files from /usr/bin
# places updated files in /usr/lib/python3/dist-packages
# tells students not to copy the brickpi or grovepi libraries anymore
# edit 11/16/2020
# some students pis dont have /home/pi/Dexter/BrickPi3 ???? anyway the copy fails so
# heres a fix - just take it from the teams files.

echo
echo "Performing GrovePi Updates"
echo "boat updated 11/16/2020"
echo

nc -z -w 5 8.8.4.4 53  >/dev/null 2>&1
online=$?
if [ $online -eq 0 ]; then
    echo "Internet connection found"
else
    echo "NO INTERNET CONNECTION DETECTED - ABORTING (press any key to exit)"
    read temp
    exit
fi

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

    cd /home/pi/Dexter/GrovePi/Firmware
    source /home/pi/Dexter/GrovePi/Firmware/grovepi_firmware_update.sh
    update_grovepi_firmware
fi


if [[ $runv4 == 1 ]];
    # update only python libraries
    then
    cd /home/pi/Dexter
    sudo apt-get install -y libi2c-dev i2c-tools libffi-dev
    git clone https://github.com/DexterInd/RFR_Tools.git
    cd /home/pi/Dexter/RFR_Tools/miscellaneous
    sudo python setup.py install
    sudo adduser $team gpio
    sudo chown root.gpio /dev/mem
    sudo chmod g+rw /dev/mem
    
    sudo rm -f /usr/bin/grovepi.py
    sudo rm -f /usr/bin/brickpi3.py
    
    echo "copying new library to package location..."
    
    sudo cp /home/pi/Dexter/GrovePi/Software/Python/grovepi.py /usr/lib/python3/dist-packages/grovepi.py
    sudo cp /home/pi/Dexter/BrickPi3/Software/Python/brickpi3.py /usr/lib/python3/dist-packages/brickpi3.py
    
    # add a line for if the pi user doesnt have brickpi3??? this has happened multiple times
    sudo cp /home/$team/Desktop/Dexter/BrickPi3/Software/Python/brickpi3.py /usr/lib/python3/dist-packages/brickpi3.py

    echo "finding old versions of libraries..."
    
    paths=$(sudo find /home/$team -type d -path /home/$team/Desktop/Dexter -prune -o -type f -name 'grovepi.py' -print)
    for p in $paths
    do
        echo "deleting" $p
        sudo rm -f $p;
    done
    
    echo
    echo "        _   ______  ______________________"
    echo "       / | / / __ \/_  __/  _/ ____/ ____/"
    echo "      /  |/ / / / / / /  / // /   / __/   "
    echo "     / /|  / /_/ / / / _/ // /___/ /___   "
    echo "    /_/ |_/\____/ /_/ /___/\____/_____/   "
    echo      
    echo "    ######################################"
    echo "    #     after this update, DO NOT      #"
    echo "    #      copy the brickpi3.py or       #"
    echo "    #    grovepi.py libraries to the     #" 
    echo "    #   location you are running code.   #"
    echo "    # they are availible system-wide now #"
    echo "    ######################################"
    echo 
fi

echo 
echo 
echo
echo "PLEASE REBOOT FOR CHANGES TO TAKE EFFECT"
echo "Seas the day. (press any button to exit)"
read temp
