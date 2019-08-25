#!/usr/bin/env python3
# GrovePi example for using setting a tone on the Grove Speaker
# (http://wiki.seeedstudio.com/Grove-Speaker/)
#
# Created by the Purdue ENGR 16X teaching team
# Contact a TA if you have any questions regarding this program.
#
# Hardware: Connect grove speaker to a digital port on the GrovePi board.
#
# Results:  When you run this program, the speaker will emit a tone at the 
#   frequency specified by the user for 100 cycles and wait for another input.
#
# Syntax:   grovepi.digitalWrite(<PORT>, <VALUE>)
#               Set the signal wire in grovepi port <PORT> to either 5V (True)
#               or 0V (False). In our case, we are powering an electromagnet 
#               to move a speaker cone forward and back.

import time
import grovepi

# Connect the Grove Speaker to digital port D3
# The speaker works on any digital port

speaker_port = 3
grovepi.pinMode(speaker_port, "OUTPUT")

try:
    print('Enter desired tone for speaker in port D3 in Hertz.')
    print('Reference: Middle C is ~261.6 Hertz.')
    print('Ctrl+C to terminate program.\n')
    
    while True:
        hertz = float(print('Enter tone frequency: '))
        
        # Convert hertz (1/seconds) to milliseconds (seconds * 1/1000)
        note_delay = (1 / hertz) * 1000
        
        for cycle in range(0, 100): # For 100 cycles...
            # Push the cone forward
            grovepi.digitalWrite(speaker_port, True)
            time.sleep(note_delay / 2)
            
            # Pull the cone back
            grovepi.digitalWrite(speaker_port, False)
            time.sleep(note_delay / 2)
            
except KeyboardInterrupt:
    # Stop sending voltage to the speaker.
    grovepi.digitalWrite(speaker_port, False)
