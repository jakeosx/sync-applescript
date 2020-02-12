# sync.Applescript
# a tool to use rsync to sync files to an external folder

# GPLv3.0
# git: https://github.com/jakeosx/sync.applescript
# version 1.0

# set the folders you want to sync
# format "/path/to/folder", "path/to/otherfolder"
# spaces as spaces, so "/path/to this folder/folder"
# no trailing / 

## SETTINGS

set myfolders to {"/path/to/folder", "path/to/otherfolder"}

# set the name of the folder at destination

set backup to "backup"

## SCRIPT

# Get the path of where the sync app is located

tell application "Finder"
	
	set current_path to container of (path to me) as alias
	set current_path2 to POSIX path of current_path
	
end tell

# set the rsync settings
# rsync settings:
# -av archive mode; verbose mode
# --delete deletes the files at the destination that were deleted on the host
# path variables are enclosed in " " so spaces can be allowed

# rsync man: https://download.samba.org/pub/rsync/rsync.html

set rsync_command to "rsync -av --delete"
# set rsync_command to "rsync -rtv --modify-window=1"

# repeat rsync with all the folders set above

repeat with theurl in myfolders
	
	do shell script "echo " & current_path2
	do shell script rsync_command & " \"" & theurl & "\" \"" & current_path2 & backup & "\""
	
end repeat

# Let us know it is complete

display alert "rsync Complete!"

# all done 