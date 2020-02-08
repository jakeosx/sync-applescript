# sync.Applescript

a tool to use rsync to sync files to an external folder

* License: GPLv3.0
* git: https://github.com/jakeosx/sync.applescript
* version 1.0

# About

This app is designed to be run from the destination location and sync files found elsewhere. 

So, for example, I keep a copy on a thumb drive. I plug in the drive, run the application and it syncs folders on the drive with folders on my computer, updating the changed files and deleted the deleted files. 

# Requirements

* macOS

While the base syncing functions are rsync, which is available on many platforms, the wrapper application is AppleScript, which is a macOS specific language, and cannot be run elsewhere. 

# WARNING

When rsync deletes files they do not go into the trash, they are deleted, gone. Recommend using a copy of a folder to test out any settings before running live data.

Which should be what you do with any random script you find on the internet, not just this one. 

# TL:DR

Put this script in the destination location. 

Add the folders into my folders variable:

```
set myfolders to {"/path/to this folder/folder"}
```

Name the folder they go into in the backup variable, make it "" for the same location

```
set bckup to "bckup"
```

Once it is all set up to run, in Script Editor:

File -> Export, select Application as file format

# Setup



Set the folders you want to sync:

* format "/path/to/folder/", "path/to/otherfolder"
* spaces as spaces, so "/path/to this folder/folder"
* no trailing / 

```
set myfolders to {"/path/to this folder/folder"}
```

# Set the Name of the Folder at Destination

Set the folder name you want all these things to be in. "Backup", for example. 

```
set backup to "backup"
```

If you want everything to go into the same location as the sync app, then just set this variable to blank, like so: 

```
set bckup to ""
```

# Rsync Settings

Rsync is a powerful copying/syncing too. This AppleScript takes all the folders you have in your settings and runs them each through the rsync command: 

```
rsync -av --delete <ORIGIN> <DESTINATION>
```

Rsync is very powerful and can do lots of damage if you aren't careful. 

The rsync manual: [https://download.samba.org/pub/rsync/rsync.html]()


## What Does That Do? 

Here's what those settings mean:

* **-av** archive mode; verbose mode
* **--delete** deletes the files at the destination that were deleted on the host

Path variables are enclosed in " " so spaces can be allowed. 

# All Done 

Once it is all set up to run, in Script Editor:

File -> Export, select Application as file format

This will create a applet that you can double click to run directly, instead of opening the Script Editor application. 

If you change settings in the script text file, you will need to repeat this export.