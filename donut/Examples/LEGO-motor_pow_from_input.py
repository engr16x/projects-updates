#!/usr/bin/env python3
# This program is an example for running a motor at a set power value. 
# The motor will turn with a constant torque, at whatever RPM allows it.
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
#
# Hardware: Connect EV3 or NXT motors to the BrickPi3 motor port A.
# Make sure that the BrickPi3 is running on a 12v power supply.
#
# Results:  When you run this program, motor A will run at the 
#   specified power.
#
# Syntax:   BP.set_motor_power(<PORT>, <VALUE>)
#               Sets motor in port <PORT> to the power value <VALUE>
#               These values are pretty arbitrary, but you could do testing
#               to determine true torque of your motor! The torque is
#               also dependent on the input voltage.

import time     # this library contains the sleep (delay) function
import brickpi3 # import BrickPi3 library

# Instantiate the BrickPi object
BP = brickpi3.BrickPi3()

# Set the power of th emotor in port A to 0
BP.set_motor_power(BP.PORT_A, 0)

print("Set motor A to power entered here (0-100)\nCtrl+C to end program\n")

while(True):
    try:
        # Let the user enter a value
        userInput = float(input('Enter power: '))
        
        # Check to make sure it is valid
        if (userInput > 0) and (userInput <= 100):
            # Set the motor to that power
            BP.set_motor_power(BP.PORT_A, userInput)
        else:
            print("{:6d} is not between 0 and 100".format(userInput))
        
    except KeyboardInterrupt:
        # Stop all motors, reset all sensors, and return LED control to the firmware.
        BP.reset_all()
