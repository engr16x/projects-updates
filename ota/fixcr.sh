#!/bin/bash

# updates all of the files on the raspberry pi 
# in the update files folder to
# ensure that they have proper LF line endings 
# instead of the default CR LF line endings
# last updated 1/5/2022 by Trevor Ladner

echo
echo Correcting line endings
echo

sed s/#!/bin/bash\r/#!/bin/bash /home/pi/Desktop/updates/plane/plane/run.sh
sed s/#!/bin/bash\r/#!/bin/bash /home/pi/Desktop/updates/boat/boat/run.sh
sed s/#!/bin/bash\r/#!/bin/bash /home/pi/Desktop/updates/donut/donut/run.sh
sed s/#!/bin/bash\r/#!/bin/bash /home/pi/Desktop/updates/elephant/elephant/run.sh
sed s/#!/bin/bash\r/#!/bin/bash /home/pi/Desktop/updates/duck/duck/run.sh

echo
echo line endings have been updated
echo

read -p 'Press Enter' -n 1 -s