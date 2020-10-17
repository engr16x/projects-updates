# modified version of the RFR setup script
# doesnt bother with wiringpi because we already have the latest version
# and it messes with permissions
# created 10/17/2020

import setuptools
setuptools.setup(
	name="Dexter_AutoDetection_and_I2C_Mutex",
	description="Dexter Industries Robot Autodetection and I2C Mutex Security",
	author="Dexter Industries",
	url="http://www.dexterindustries.com/GoPiGo/",
	py_modules=['auto_detect_robot', 'auto_detect_rpi', 'I2C_mutex', 'di_i2c', 'di_mutex'],
	install_requires=['smbus-cffi', 'pyserial', 'python-periphery'],
)