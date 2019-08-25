#!/usr/bin/env python3
# GrovePi example for using reading a value from the digital hall effect sensor.
# (http://wiki.seeedstudio.com/Grove-Hall_Sensor/)
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
#
# Hardware: Connect grove hall sensor to a digital port on the GrovePi board.
#
# Results:  When you run this program, the board will read the hall sensor 
#   every tenth of a second.
#
# Syntax:   grovepi.digitalRead(<PORT>)
#               Reads either 5V (HIGH) or 0V (LOW)

import time
import grovepi

# Connect the Grove Hall Sensor to digital port D2
hall_port = 2

# Set the board to read values from this port.
grovepi.pinMode(hall_port,"INPUT")

try:
    while True:
        try:
            # Read from the sensor
            hall_value = grovepi.digitalRead(hall_port)
        
            # Print the value
            print("Value: {}".format(hall_value))
            
            # wait a tenth of a second
            time.sleep(0.1)
        
        except IOError:
            print("Input Error")
except KeyboardInterrupt:
    print("Program Terminated.")
