# sync.Applescript

a tool to use rsync to sync files to an external folder

* License: GPLv3.0
* git: https://github.com/jakeosx/sync.applescript
* version 1.1

# About

This Applescript is designed to be run from the destination location and sync files found elsewhere. 

So, for example, I keep a copy on a thumb drive. I plug in the drive, run the application and it updates folders on the drive to match the folders on my computer---updating the changed files and deleting the deleted files. 

It is a one-way sync, updating <DESTINATION> directory with any changes in <ORIGIN> directory, filling a backup role, rather than a true sync.

# Requirements

* macOS

While the base syncing functions are rsync, which is available on many platforms, the wrapper application is AppleScript, which is a macOS specific language, and cannot be run elsewhere. 

AppleScript Developer Info: https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptX/AppleScriptX.html

# WARNING

When rsync deletes files they do not go into the trash, they are deleted, gone. Recommend using a copy of a folder to test out any settings before running live data. 

Which should be what you do with any random script you find on the internet, not just this one. 

Make sure you have a regular back up of your files.

# TL:DR

Put this script in the destination location. 

Add the folders into my folders variable:

```
set myfolders to {"/path/to/folder", "path/to/otherfolder"}
```

Name the folder they go into in the backup variable, make it "" for the same location

```
set backup to "backup"
```

Is your drive formatted either Fat32 or exFat? If so, change this to "yes"

```
set fat32 to "no"
```

Once it is all set up to run, in Script Editor:

File -> Export, select Application as file format

# Setup

Set the folders you want to sync:

* format "/path/to/folder/", "path/to/otherfolder"
* spaces as spaces, so "/path/to this folder/folder"
* no trailing / 
* one continuous line, don't hit enter! 

```
set myfolders to {"/path/to/folder", "path/to/otherfolder"}
```

# Set the Name of the Folder at Destination

Set the folder name you want all these things to be in. "Backup", for example. 

```
set backup to "backup"
```

If you want everything to go into the same location as the sync app, then just set this variable to blank, like so (the two quotation marks are required, no spaces inside): 

```
set backup to ""
```

# Rsync Settings

Rsync is a powerful copying/syncing too. This AppleScript takes all the folders you have in your settings and runs them each through the rsync command: 

```
rsync -av --delete <ORIGIN> <DESTINATION>
```

<ORIGIN> will be the folders you set as `myfolders`

<DESTINATION> will be where the script is located, in a folder you named with the variable `backup`

Rsync is very powerful and can do lots of damage if you aren't careful. Any changes to this line should be tested with dummy files before used on actual ones. (and a reminder to back up your computer regularly)

The rsync manual: https://download.samba.org/pub/rsync/rsync.html

## What Does That Do? 

Here's what those settings mean:

* **-av** archive mode; verbose mode
* **--delete** deletes the files at the destination that were deleted on the host

Path variables are enclosed in " " so spaces can be allowed. 

# Rsync for FAT32 and exFAT drives 

There are aspects of your files that are not saved on a FAT32 or exFAT device. Things like permissions and over ship. Additionally the time stamp isn't quite the same, which will result in all the files being copied over each time, rather than just the deltas. 

So, if you want FAT format for its portability, we can tweak the rsync commands some to save time on the syncs. 

```
rsync -rtv --modify-window=1 <ORIGIN> <DESTINATION>
```

<<<<<<< HEAD
You can set this by changing the setting to "yes"

```
set fat32 to "no"
```

## What Does That Do? 
=======
You can set this by commenting this line (add a # to the beginning)

```
set rsync_command to "rsync -av --delete"
```

And in comment this one (remove the # at the begining of the line)

```
# set rsync_command to "rsync -rtv --modify-window=1"
```

## What does that do? 
>>>>>>> refs/remotes/github/master

* **-r** recursive; go into any sub directories 
* **-t** times; preserve the modification times 
* **-v** verbose 
* **--modify-window=1** this adds a +/- 1 second window to the time check, which will help with time stamp differences

Note: this will probably cause a re-sync of all files after Daylight Savings, twice a year. 

Source: https://askubuntu.com/questions/112863/rsync-not-working-between-ntfs-fat-and-ext

# All Done 

Once it is all set up to run, in Script Editor:

File -> Export, select Application as file format

This will create a applet that you can double click to run directly, instead of opening the Script Editor application. 

If you change settings in the script text file, you will need to repeat this export.