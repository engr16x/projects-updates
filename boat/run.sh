#!/bin/bash

# updates the gpio permissions
# edit 3/3/2022
# by Trevor Ladner

echo
echo "Performing GrovePi Updates"
echo "boat updated 03/03/2022"
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

runv1=0
while [[ $runv1 == 0 ]]; do
    echo"Please enter the team number: "
    read tnum
    if tnum <= 80;
        runv1=1
        team="team_$tnum"
    fi
    if tnum > 80;
        echo "Please enter a team number less than 80";
        runv1=0
    fi
done


echo "giving team gpio permissions"
sudo adduser $team gpio
sudo chown root.gpio /dev/mem
sudo chmod a+rw /dev/mem

echo "giving executable permissions to examples"
sudo chmod -R a+rw /home/$team/Desktop/Examples/GrovePi
sudo chmod -R a+rw /home/$team/Desktop/Examples/BrickPi3
sudo chmod -R a+rw /home/$team/Desktop/Examples/DIIS
sudo chmod -R a+rw /home/$team/Desktop/Examples/Custom
sudo chmod -R a+rw /home/$team/Desktop/Examples/IMU
sudo chmod -R a-x /home/$team/Desktop/Examples/GrovePi
sudo chmod -R a-x /home/$team/Desktop/Examples/BrickPi3
sudo chmod -R a-x /home/$team/Desktop/Examples/DIIS
sudo chmod -R a-x /home/$team/Desktop/Examples/Custom
sudo chmod -R a-x /home/$team/Desktop/Examples/IMU

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