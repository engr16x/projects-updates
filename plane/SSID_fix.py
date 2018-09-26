import os

# Here is the file we are changing
filename = '/etc/hostapd/hostapd.conf'

# We can get team number by looking at their username
homedir = os.environ[ 'HOME' ]
team_num = homedir.replace( '/home/team_' , '' )


old_num = '1' + team_num

#Just read the file to a list, 
#make the changes to the strings there, 
#create a new file overriding the old file 
#write the edited strings to the new file.

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

with open( filename , 'w' ) as file:
  for line in newfile:
    file.write( line )

#instruct the user to sudo reboot
if not completed:
  print( 'No changes were made to the file hostapd.conf' )
  print( 'Please report this to a TA' )
else:
  print( 'Please use sudo reboot for changes to take effect' )
