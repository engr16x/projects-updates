#!/bin/bash

# Short program to delete extant student accounts on the raspberry pis
# Written by Nicholas Masso 1/10/2019
# With code written by Trevor Meyer in summer 2018
# Edited by Nicholas Masso 8/25/2019
# Edited by Trevor Ladner 1/17/2022
# Edited by [Braden?] via Owen Johnson 8/26/2023


echo "Welcome to the ENGR16X account reset script!"
echo "This script will clear all data on existing student accounts,"
echo "and then recreate them with fresh settings"
echo
echo

teams=()
file="/etc/passwd"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
  if [[ $f1 == *"team"* ]] || [[ $f1 == *"section"* ]]; 
  then
    echo "$f1 found"
    teams+=($f1)
  fi
done <"$file"


for account in ${teams[@]}
do
  echo
  echo "Resetting $account account..."
  echo 
  echo "Stopping all processes being run"
  killall -u $account
  echo "Removing any existing Account Structure"
  sudo deluser $account
  sudo rm -r /home/$account
  echo "Creating $account account"
  sudo adduser $account --disabled-login --gecos "$account,0,0,0"
  echo "Changing $account account password"
  echo "$account:$account" | chpasswd
  echo "Adding reboot, shutdown, and poweroff sudo access"
  echo "$account ALL=NOPASSWD: /sbin/reboot, /sbin/shutdown, /sbin/poweroff" | sudo EDITOR='tee -a' visudo
  echo "$account ALL=NOPASSWD: /home/pi/projects-rpi-setup-6/files/new_desktop/*" | sudo EDITOR='tee -a' visudo
  echo "Creating Desktop"
  sudo mkdir /home/$account/Desktop
  sudo cp -r /home/pi/projects-rpi-setup-6/files/new_desktop/. /home/$account/Desktop/

  
  echo "Adjusting Permissions"
  sudo chown -R $account:$account /home/$account/Desktop
  sudo chown -R pi:pi /home/$account/Desktop/"UPDATE FILES"
  sudo adduser $account i2c
  sudo adduser $account spi
  sudo chmod -R 4755 /home/$account/Desktop/"UPDATE FILES"
  #sudo python3 runFilesAsCreator.py /home/$account/Desktop/"UPDATE FILES"
  
done

echo "giving team gpio permissions"
sudo adduser $team gpio
sudo chown root.gpio /dev/mem
sudo chmod a+rw /dev/mem


echo
echo "Adding extra example files"
echo

sudo wget https://github.com/engr16x/projects-updates/raw/master/extra-examples/extra-examples.zip -P /home/instructor/Desktop/Examples/
sudo mkdir /home/$account/Desktop/Examples/extra-examples
sudo unzip /home/instructor/Desktop/Examples/extra-examples.zip -d /home/$account/Desktop/Examples/extra-examples
sudo rm /home/instructor/Desktop/Examples/extra-examples.zip

echo
echo "Adding Grove and Brick Pi Example files"
echo

# Dexter Example Files
sudo mkdir /home/$account/Desktop/Examples/BrickPi3
sudo mkdir /home/$account/Desktop/Examples/GrovePi
sudo cp -r /home/instructor/Desktop/Examples/BrickPi3/. /home/$account/Desktop/Examples/BrickPi3/
sudo cp -r /home/instructor/Desktop/Examples/GrovePi/. /home/$account/Desktop/Examples/GrovePi/

echo
echo "Removing necessary file permissions"
sudo python3 /home/pi/projects-rpi-setup-6/setup_files/20_removePermissions.py

echo
echo "Changing Desktop Background"
sudo /home/pi/projects-rpi-setup-6/setup_files/21_changeBackground.sh $account

echo
echo "Account Setup Complete!"
echo "Please login to each account created to verify successful creation"
echo
echo "Enter 'sudo reboot' to finish updating settings"
echo
