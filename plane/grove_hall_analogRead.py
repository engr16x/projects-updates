'''
This example script was developed by Trevor Ladner for the purposes of
Engineering 161/200. This code is intended to be used for the Grove Pi
Hall Effect sensor following the end of Dexter's support for the sensor.

The sensor reads in data from 0-1024 relating to magnetic field.
'''

import grovepi
import time

# set I2C to use the hardware bus
grovepi.set_bus("RPI_1")

# Connect the Grove hall effect sensor to analog port 2
# SIG,NC,VCC,GND
hall = 2

while True:
    try:
        # Read field value from hall
        print(grovepi.analogRead(hall))

    except Exception as e:
        print ("Error:{}".format(e))
    
    time.sleep(0.1) # don't overload the i2c bus