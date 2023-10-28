# Cockswitch

A script to switch between different formats in Cockatrice on mac (and linux) 


## Installation

Just copy or link `cockswitch` to your `$PATH`.
If you are in Linux, go into the cockswitch script and comment out the Mac default location, and uncomment the Linux one. If on either OS you've put Cockatrice somewhere else, you'll also need to set this in the script.

## Usage

For each format you want to setup, do the following:

Set Cockatrice up to have the settings you want for the format.
cockswitch -n FORMAT
cockswitch -u FORMAT

Now, whenever you want to play that format:
cockswitch -s FORMAT
cockatrice

(You could use the above two lines as a very tiny script to run cockswitch and cockatrice in a single command. I have these linked off my application menu for a seamless experience.)

The tool will set: Cards, tokens, card image download locations, card and token update locations, filters on a server, and default game creation settings. (It also grabs a couple of other things in global. This isn't likely to affect you, but if it does take a look in global.ini)


