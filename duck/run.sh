#!/bin/bash

VCHECK=`cat /etc/motd | grep "6\."`
if [ "$VCHECK" != "" ]
then
    echo "THIS SCRIPT WAS WRITTEN FOR VERSION 5 ENGR OS BUILDS"
    echo "YOU ARE RUNNING VERSION: 6"
    echo "THIS SCRIPT WILL FAIL!"
    echo
    echo "Press [enter] to exit."
    read temp
    exit 0
fi

echo
echo "Running hardware test..."
echo

python /home/pi/Desktop/updates/duck/duck/hardware_test.py

echo
echo
echo "Let's get quackin"
read temp
