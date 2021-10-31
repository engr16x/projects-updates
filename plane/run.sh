#!/bin/bash

echo
echo "Downloading Hall Effect Example Script V1.0"

# Know what accounts are on the RPi
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
	echo "Updating example codes"
	
	destination = /home/$account/Desktop/Examples/Custom/grove-read_hall_sensor.py
	source = /home/pi/Desktop/updates/plane/plane/grove_hall_analogRead.py

	# Delete the old Hall Example Script
	rm -f $destination
	echo 
	# Copy the new Hall Example Script
	cp $source $destination
done

read -p 'Press Enter' -n 1 -s