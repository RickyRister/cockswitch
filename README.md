# Cockswitch

A script to switch between different custom formats in [Cockatrice](https://cockatrice.github.io) on mac (and linux) 

On windows, you can have a separate portable install of Cockatrice for each format. 
However, portable clients don't work on mac, since Cockatrice always reads from the same folder.

## Installation

Just copy or link `cockswitch` to your `$PATH`.

If you are using Linux, go into the cockswitch script and comment out the Mac default location, and uncomment the Linux one. 
If on either OS you've put Cockatrice somewhere else, you'll also need to change the trice_path variable in the script.

## Usage

### Setup

For each format you want to setup, do the following:

Set Cockatrice up to have the settings you want for the format. Then run:
```shell
cockswitch -n FORMAT	# Creates a backup folder for the format
cockswitch -u FORMAT	# Copies the current card files to the folder
cockswitch -t FORMAT	# Copies the current settings files to the folder
```

Or you can do it all at once. 
```shell
cockswitch -nut FORMAT
```

Now, whenever you want to play that format:
```shell 
cockswitch FORMAT	# Overwrites the currently active files with the ones from the folder
cockatrice	# Or you can just open the Cockatrice app normally
```

(You could use the above two lines as a very tiny script to run cockswitch and cockatrice in a single command. 
I have these linked off my application menu for a seamless experience.)

The tool will set: 
* `-u`: Cards, tokens, custom images
* `-t`: Card image download locations, card and token update locations, filters on a server, default game creation settings. 
  (It also grabs a couple of other things in global. This isn't likely to affect you, but if it does take a look in global.ini)

### Updating a format

#### Oracle

Oracle stores your most recent download url in global.ini, so if you stored the settings files correctly, 
all you have to do is switch over to the format and run Oracle; the correct download urls will already be filled in for you! 
Don't forget to `cockswitch -u` afterwards.

If you haven't set up things correctly, then you'll have to manually paste in the download urls when you run Oracle. 
You can `cockswitch -t` afterwards to save the settings files (which should contain the download url you just used).

#### Manual

If you're manually replacing the cards.xml and tokens.xml files inside your cockatrice folder, then you can keep doing that. 
Just remember to `cockswitch -u` afterwards.

Or, you can just go inside the formats folder and directly replace the relevant files. 
Files for each format are saved to `formats/<FORMAT>` inside the Cockatrice app support folder.

### Local Custom Card Images

Cockswitch supports the switching of local custom card images, for formats that use local card images located in the `pics/CUSTOM` folder 
(instead of downloading images from an external source on-the-fly).

Create a folder named `CUSTOM` inside the format's folder (located in `formats/<FORMAT>` inside the Cockatrice app support folder),
then put all card image folders that you would put inside Cockatrice's `pics/CUSTOM` folder inside that `CUSTOM` folder.

When you switch to that format, cockswitch will symlink all folders in `formats/<FORMAT>/CUSTOM` to Cockatrice's `pics/CUSTOM`.
When you switch to another format, cockswitch will delete all those symlinks from `pics/CUSTOM`.

> **NOTE:** Cockatrice <= 2.9 has a bug where it doesn't traverse symlinked directories when looking for card images in the custom image folder. Use the `-w` flag to enable the workaround.
>
> #### `-w`: Symlink folders in `pics`
>
> Instead of creating the symlinks inside `pics/CUSTOM`, cockswitch will create the symlinks in `pics`.
>
> Cockatrice will still be able to find the card image **as long as** the name of the folder the image is located in matches the set code of the card.

