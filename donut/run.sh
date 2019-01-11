#!/bin/bash

echo
echo "Running Donut update script"

while true; do
    read -p "Do you wish to run the account reset script? (y/n)" yn
    case $yn in
        [Yy]* ) sudo ./engr16x_reset.sh; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo
echo
echo "--------------------------"
echo "Donut has finished running"
echo
read temp
