#!/bin/bash

# Short program to delete extant student accounts on the raspberry pis
# Written by Nicholas Masso 1/10/2019
# With code written by Trevor Meyer in summer 2018


echo "Welcome to the ENGR16X account reset script!"
echo "This script will clear all data on existing student accounts,"
echo "and then recreate them with fresh settings"
echo
echo

teams=()
file="/etc/passwd"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
  if [[ $f1 == *"team"* ] || [ $f1 == *"section"* ]]; 
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
  echo "$account ALL=NOPASSWD: /home/pi/Desktop/source_files/*" | sudo EDITOR='tee -a' visudo
  echo "Creating Desktop"
  sudo mkdir /home/$account/Desktop
  sudo cp -r /home/pi/Desktop/newDesktop/. /home/$account/Desktop/
  echo "Adjusting Permissions"
  sudo chown -R $account:$account /home/$account/Desktop
  sudo chown -R pi:pi /home/$account/Desktop/"UPDATE FILES"
  sudo chmod 755 /home/$account/Desktop/setupAccount.sh
  sudo adduser $account i2c
  sudo adduser $account spi
  sudo chmod -R 4755 /home/$account/Desktop/"UPDATE FILES"
  #sudo python3 runFilesAsCreator.py /home/$account/Desktop/"UPDATE FILES"
done

echo
echo "Removing necessary file permissions"
sudo python3 /home/pi/Desktop/setup_files/removePermissions.py

echo
echo "Account Setup Complete!"
echo "Please login to each account created to verify successful creation"
echo
echo "Enter 'sudo reboot' to finish updating settings"
echo


