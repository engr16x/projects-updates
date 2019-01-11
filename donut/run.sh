#!/bin/bash

echo
echo "Running Donut update script"

runv=0
while true; do
    read -p "Do you wish to run the account reset script? (y/n) " yn
    case $yn in
        [Yy]* ) $runv=1; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [[ $runv == 1 ]];
    sudo chmod +x /home/pi/Desktop/updates/donut/donut/engr16x_reset.sh
    sudo /home/pi/Desktop/updates/donut/donut/engr16x_reset.sh
fi

echo
echo "--------------------------"
echo "Donut has finished running"
echo
read temp
