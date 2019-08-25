#!/usr/bin/env python3
# This program is an example for turning a motor
# to a target position input by the user
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
#
# Hardware: Connect EV3 or NXT motors to the BrickPi3 motor port A.
# Make sure that the BrickPi3 is running on a 12v power supply.
#
# Results:  When you run this program, motor A will run to match
#   the position as input by the user.
#
# Syntax:   BP.get_motor_encoder(<PORT>)
#               Returns current position of motor (+/- degrees rotated
#				from 'zero' reference point)
#
#           BP.offset_motor_encoder(<PORT>, <VALUE>)
#               Defines 'zero' reference point as specified by VALUE
# 				(+/- degrees from previous 'zero' reference point)
#
#           BP.set_motor_position(<PORT>, <VALUE>)
#               Moves motor to reach position as specified by VALUE
# 				(+/- degrees from 'zero' reference point)

import time     # this library contains the sleep (delay) function
import brickpi3 # import BrickPi3 library

# Instantiate the BrickPi object
BP = brickpi3.BrickPi3()

try:
	zeroPositionA = BP.get_motor_encoder(BP.PORT_A)
	BP.offset_motor_encoder(BP.PORT_A, zeroPositionA) # Set current position of motor A to 'zero' position.
    
    print("Set motor A to position entered here\nCtrl+C to end program\n")

	while True: # Loop runs indefinitely until manual termination by Ctrl+C.

		try:
            # Accept user input for target position (+/- degrees from 'zero' reference point)
			targetPosition = float(input("Enter position (degrees): "))
            
            # Set position of motor A to match user input target
			BP.set_motor_position(BP.PORT_A, targetPosition)
			print("Motor A position: {:6d}".format(targetPosition))

		except: # Run if input cannot be converted to float
			print("Please enter a valid number.")

		time.sleep(3)  # Some delay to allow motor to reach desired position

except KeyboardInterrupt: # Run if program manually terminated by keyboard interrupt Ctrl+C.
	BP.reset_all()        # Unconfigure the sensors, disable the motors, and restore the LED to the control of the BrickPi3 firmware.
