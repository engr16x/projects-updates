#!/bin/bash

# updates the gpio permissions
# edit 3/1/2022

echo
echo "Performing GrovePi Updates"
echo "boat updated 03/01/2022"
echo

echo "you are logged in as: " $USER
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
    read -p "Do you need to update the gpio permissions (y/n) " yn
    case $yn in
        [Yy]* ) runv1=1; runv2=1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Enter the team number:"
read tnum
team="team_$tnum"

echo giving team gpio permissions
sudo chmod a+rw /dev/gpiomem

echo giving executable permissions to examples
sudo chmod -R 777 /home/$team/Desktop/Examples/GrovePi
sudo chmod -R 777 /home/$team/Desktop/Examples/BrickPi
sudo chmod -R 777 /home/$team/Desktop/Examples/DIIS
sudo chmod -R 777 /home/$team/Desktop/Examples/Custom
sudo chmod -R 777 /home/$team/Desktop/Examples/IMU

echo 
echo 
echo
echo "PLEASE REBOOT FOR CHANGES TO TAKE EFFECT"
echo "Seas the day. (press any button to exit)"
echo "        _    _"
echo "     __|_|__|_|__"
echo "   _|____________|__"
echo "  |o o o o o o o o /"
echo "~~~~~~~~~~~~~~~~~~~~~~"
read temp