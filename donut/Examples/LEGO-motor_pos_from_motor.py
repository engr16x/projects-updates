#!/usr/bin/env python3
# This program is an example for turning a motor to a target position 
# set by the encoder of another motor.
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
# 
# Hardware: Connect EV3 or NXT motors to the BrickPi3 motor ports A and D. 
# Make sure that the BrickPi3 is running on a 12v power supply.
#
# Results:  When you run this program, motor A will run to match the position 
#   of motor D. Manually rotate motor D, and motor A will follow.
#
# Syntax:   get_motor_encoder(<PORT>)
#               Returns current position of motor (+/- degrees rotated 
#               from 'zero' reference point)
#
#           offset_motor_encoder(<PORT>, <VALUE>)
#               Defines 'zero' reference point as specified by VALUE 
#               (+/- degrees from previous 'zero' reference point)
#
#           set_motor_position(<PORT>, <VALUE>)
#               Moves motor to reach position as specified by VALUE 
#               (+/- degrees from 'zero' reference point)                    ''

import time     # this library contains the sleep (delay) function
import brickpi3 # import BrickPi3 library

# Instantiate the BrickPi object
BP = brickpi3.BrickPi3()

try:
    # Set current position of motor A to 'zero' position.
	zeroPositionA = BP.get_motor_encoder(BP.PORT_A)
	BP.offset_motor_encoder(BP.PORT_A, zeroPositionA) 
	
    # Set current position of motor D to 'zero' position.
	zeroPositionD = BP.get_motor_encoder(BP.PORT_D)
	BP.offset_motor_encoder(BP.PORT_A, zeroPositionD)
    
    print("Set motor A to position corresponding to motor D\nCtrl+C to end program\n")

	
	while True: # Loop runs indefinitely until manual termination by Ctrl+C.
		
		targetPosition = BP.get_motor_encoder(BP.PORT_D)   # Read position of motor D
		BP.set_motor_position(BP.PORT_A, targetPosition)   # Set position of motor A to match motor D
		
		currentPosition = BP.get_motor_encoder(BP.PORT_A)) # Read position of motor A	
		print("Motor A target: {:6d}  Motor A position: {:6d}".format(targetPosition, currentPosition))
		
		time.sleep(0.02)  # Delay for 0.02 seconds to reduce RaspberryPi CPU load

except KeyboardInterrupt: # Run if program manually terminated by keyboard interrupt Ctrl+C.
	BP.reset_all()        # Unconfigure the sensors, disable the motors, and restore the LED to the control of the BrickPi3 firmware.