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
# Syntax:   BP.set_motor_dps(<PORT>, <VALUE>)
#               Sets motor in port <PORT> to the degrees-per-second value <VALUE>
#               The motor will apply whatever torque is required to keep this 
#               rotational valocity. There is an upper limit, but it could be 
#               different based on input voltage and motor type.

import time              #library for sleep function
import brickpi3          #library for BrickPi dependencies

BP = brickpi3.BrickPi3() #creating a BP object
MOTOR = BP.PORT_A        #defining the motor port to be used, motor should be plugged into the
                         #corresponding port on the BrickPi
try:
    print('Enter desired speed for motor A in degrees/sec.\nCtrl+C to terminate program.\n')
    
    while True:
        dps = float(input('Enter desired speed: ')) #get dps from user input

        BP.set_motor_dps(MOTOR, dps) #sets motor to dps input
        
        print('Current speed is {:.4f} degrees/sec'.format(dps))
        
        time.sleep(0.02)

except KeyboardInterrupt: #ctrl+c will trigger the program to terminate
    # Stop all motors, reset all sensors, and return LED control to the firmware.
    BP.reset_all()
