# Hardware test program for class rpis
# written by nick masso nmasso@purdue.edu
# created 1/26/2020
# edited 2/9/2020

import sys
import time
import subprocess

print("""
    __                   __
   / /_  ____ __________/ /      ______ _________
  / __ \/ __ `/ ___/ __  / | /| / / __ `/ ___/ _ \\
 / / / / /_/ / /  / /_/ /| |/ |/ / /_/ / /  /  __/
/_/_/_/\__,_/_/  _/__,_/ |__/|__/\__,_/_/   \___/
  / /____  _____/ /______
 / __/ _ \/ ___/ __/ ___/  for engr 16X pi kits
/ /_/  __(__  ) /_(__  )    written by Nick Masso
\__/\___/____/\__/____/       january 2020
""")

try:
    import brickpi3
    import grovepi
except:
    sys.path.append("/home/pi/Desktop/newDesktop/Dexter/BrickPi3/Software/Python/")
    sys.path.append("/home/pi/Desktop/newDesktop/Dexter/GrovePi/Software/Python/")
    import brickpi3
    import grovepi

# detect i2c devices
out = subprocess.Popen(["i2cdetect","-y", "1"],stdout=subprocess.PIPE)
results = str(out.communicate())
results = results.split("\\n")
devs = []
for row in range(1,len(results)):
    results[row] = results[row].strip(' ').split(' ')
    for col in range(1,len(results[row])):
        if results[row][col] != "--" and results[row][col] != "" and results[row][col] != "None)":
            devs.append(results[row][col])

print("\nFound " + str(len(devs)) + " I2C devices: " + str(devs))

# brickpi is usually #40
# imu was like #68

error = []
try:
    BP = brickpi3.BrickPi3()
    grovepi.version()
except TypeError:
    message = str(sys.exc_info()[1])
    if "catching" in message:
        print("Unable to connect to BrickPi board.")
        error.append("brickpi")
    elif "subscriptable" in message:
        print("Unable to connect to GrovePi board.")
        error.append("grovepi")
    else:
        print("Unexpected error: \n" + message)
        error.append("other TypeError")
except:
    print("Unexpected error: \n" + str(sys.exc_info()[1]))
    error.append("other " + str(sys.exc_info()[0]))

if "grovepi" not in error:
    #perform grovepi tests
    # digial ports 2-8
    # analog ports 0-2
    # three I2C ports
    gp_version = grovepi.version()          #string

    print("Found GrovePi version " + gp_version + " (note: 1.2.7 is default, 1.4.0 is newest)")
    print("\nTesting ONLY GROVEPI sensors...(press ctrl+c to stop)\n")

    print("""
              __ ultrasonic sensor
             /
--Analog--  \/--------Digital---------
A0  A1  A2  D2  D3  D4  D5  D6  D7  D8""")

    counter = 0
    try:
        while True:
            for port in range(0,3):
                if counter == 0:
                    grovepi.pinMode(port + 14,"INPUT")
                print("{:<4}".format(grovepi.analogRead(port)),end="")
            print("{:<4}".format(grovepi.ultrasonicRead(port)), end="")
            for port in range(3,9):
                if counter == 0:
                    grovepi.pinMode(port,"INPUT")
                print("{:<4}".format(grovepi.digitalRead(port)), end="")
            print("Time: {} sec\r".format(counter/10),end="")
            time.sleep(0.1)
            counter += 1
    except KeyboardInterrupt:
        print("\n")

bp_picture = """
 _______________
|               | 2 || 1 || A |
|               |___||___||___|
|                          ____
|    BrickPi3             | B
|                         |____
|                          ____
|                         | C
|                         |____
|                ___  ___  ___
|               |   ||   ||   |
|_______________| 3 || 4 || D |
"""

if "brickpi" not in error:
    # perform brickpi tests
    bp_version = BP.get_version_firmware()  #string
    bp_voltage = BP.get_voltage_battery()   #float

    print("\nFound BrickPi3 version " + bp_version + " (note: 1.4.3 is default, 1.4.8 is newest)")
    print("Current voltage: " + str(bp_voltage))
    if bp_voltage < 8:
        print("######  WARNING  ######\n# LOW BATTERY VOLTAGE #\n#####################")
    elif bp_voltage > 14:
        print("######  WARNING  ######\n#     HIGH VOLTAGE    #\n#####################")
    
    print("\nSensor 1: Touch\nSensor 2: Ultrasonic\n" +
    "Sensor 3: Color\nSensor 4: Gyro\nMotors A-D: 120 deg/s")

    print(bp_picture)
    
    
    t = [
        BP.SENSOR_TYPE.TOUCH,
        BP.SENSOR_TYPE.NXT_ULTRASONIC,
        BP.SENSOR_TYPE.EV3_ULTRASONIC_CM,
        BP.SENSOR_TYPE.NXT_COLOR_RED,
        BP.SENSOR_TYPE.EV3_COLOR_COLOR,
        BP.SENSOR_TYPE.EV3_GYRO_ABS_DPS
        ]
    
    print("Testing sensors and motors...(press ctrl+c to stop)")
    print(" -S1-  -S2-  -S3-  -S4- ")

    motors = [BP.PORT_A, BP.PORT_B, BP.PORT_C, BP.PORT_D]
    sensors = [BP.PORT_1, BP.PORT_2, BP.PORT_3, BP.PORT_4]
    counter = 0

    BP.set_sensor_type(sensors[0],t[0])
    BP.set_sensor_type(sensors[1],t[1])
    BP.set_sensor_type(sensors[2],t[4])
    BP.set_sensor_type(sensors[3],t[5])
    
    try:
        for m in motors:
            BP.set_motor_dps(m,120)
        while True:
            for s in sensors:
                try:
                    val = int(BP.get_sensor(s))
                except:
                    val = 0
                print("{:<6}".format(val),end="")
            print("Time: {} sec\r".format(counter/10),end="")
            time.sleep(0.1)
            counter += 1
    except KeyboardInterrupt:
        for m in motors:
            BP.set_motor_dps(m,0)
        pass

print("\nCompleted Testing.")
