#!/usr/bin/env python3
# GrovePi example for using reading a value from the light sensor.
# (http://www.seeedstudio.com/wiki/Grove_-_Light_Sensor)
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
#
# Hardware: Connect grove light sensor to an analog port on the GrovePi board.
#
# Results:  When you run this program, the board will read the light sensor 
#   every tenth of a second.
#
# Syntax:   grovepi.analogRead(<PORT>)
#               Reads a value between the input voltage and ground voltage.

import time
import grovepi

# Connect the Grove Light Sensor to analog port A0
# SIG,NC,VCC,GND
light_sensor = 0

# Set the board to read values from this port.
grovepi.pinMode(light_sensor,"INPUT")

try:
    while True:
        try:
            # Get sensor value
            sensor_value = grovepi.analogRead(light_sensor)

            # Calculate resistance of sensor in K
            resistance = (float)(1023 - sensor_value) * 10 / sensor_value

            print("sensor_value = %d resistance = %.2f" %(sensor_value,  resistance))
            time.sleep(.1)

        except IOError:
            print ("Error")
except KeyboardInterrupt:
    print('Program Stopped.')