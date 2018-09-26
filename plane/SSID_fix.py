# This is a short code that changes the SSID
# For single-digit teams, we made them 10X instead of 0X
# And this returns it to normal

import os

# Here is the file we are changing
filename = '/etc/hostapd/hostapd.conf'

# We can get team number by looking at their username
homedir = os.environ[ 'HOME' ]
team_num = homedir.replace( '/home/team_' , '' )


old_num = '1' + team_num

# This while loop reads the file to a list
# Makes the changes to the strings there

newfile = []
found = False
completed = False

while not found:
  try:
    with open( filename , 'r' ) as file:
      for line in file:
        found = True
        foundReplace = False
        if old_num in line:
          newfile.append( line.replace( old_num , team_num ) )
          foundReplace = True
          completed = True

        if not foundReplace:
          newfile.append( line )
  except FileNotFoundError: 
      print( 'File was not found - please ask a TA to verify path' )
      print(filename)
      filename = input( 'Please enter proper path: ' )

# This creates a new file overriding the old file 
# And writes the edited strings to the new file

with open( filename , 'w' ) as file:
  for line in newfile:
    file.write( line )

# Here are some outputs for the user
# Notifying the user if certain things happened

if not completed:
  print( 'No changes were made to the file hostapd.conf' )
  print( 'Please report this to a TA' )
else:
  print( 'Please use sudo reboot for changes to take effect' )
