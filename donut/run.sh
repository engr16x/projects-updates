#!/bin/bash

echo
echo "Running Donut update script"
echo
echo " _       _____    ____  _   _______   ________"
echo "| |     / /   |  / __ \/ | / /  _/ | / / ____/"
echo "| | /| / / /| | / /_/ /  |/ // //  |/ / / __  "
echo "| |/ |/ / ___ |/ _, _/ /|  // // /|  / /_/ /  "
echo "|__/|__/_/  |_/_/ |_/_/ |_/___/_/ |_/\____/   "
echo 
echo "THIS WILL DELETE ALL TEAM/SECTION USER FILES"
echo "DO NOT RUN UNLESS YOU ARE LOGGED IN AS INSTRUCTOR"
echo "you are logged in as: " $USER
echo


runv1=0
runv2=0
while [[ $runv1 == 0 ]]; do
    read -p "Do you wish to run the account reset script? (y/n) " yn
    case $yn in
        [Yy]* ) runv1=1; runv2=1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [[ $runv2 == 1 ]];
    then
    sudo chmod +x /home/pi/Desktop/updates/donut/donut/engr16x_reset.sh
    sudo /home/pi/Desktop/updates/donut/donut/engr16x_reset.sh
fi

echo
echo "--------------------------"
echo "Donut has finished running"
echo
read temp
