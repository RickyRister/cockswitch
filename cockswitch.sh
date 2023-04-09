#!/bin/bash

usage_info () {
	echo ""
	echo "Switch the current cards.xml and tokens.xml file in the cockatrice folder"
	echo "Usage: cockswitch <Format>	Switch the current card files to format"
	echo "       cockswitch -s <Format>	Saves the current card files as format"
	echo ""
	echo "Card files for each format should be stored in storage/<format> inside the Cockatrice folder"
	echo ""
	echo "Options:"
	echo "-s FORMAT	instead saves the current card files into the storage_path"
  	echo "-n FORMAT	creates a new format"
  	echo "-d FORMAT	deletes the format"
}

#================================
# Constants
#================================

trice_path="$HOME/Library/Application Support/Cockatrice/Cockatrice"
storage_path="$trice_path/storage"
card_file='cards.xml'
token_file='tokens.xml'

#================================
# optargs
#================================

s=false
n=false
d=false

process_optargs () {
  	local OPTIND
  	while getopts "snd" option; do
  	 	case $option in
   	   		s)
   	     		s=true ;;
   	   		n)
   	     		n=true ;;
   	   		d)
   	     		d=true ;;
   	  		\?)
   	     		echo "Invalid argument: ${OPTARG}"
   	     		exit 1 ;;
   		esac
  	done

  	shift $((OPTIND-1))

  	# validate args
  	if [ $# -ne 1 ]; then 
		usage_info 
		exit 1
 	fi

 	# go to cockatrice folder
 	cd "$trice_path"

 	# run appropriate program
 	if [ $s = 'true' ]; then
 	 	cockstore "${@}"
 	else
  		cockswitch "${@}"
  	fi
}

#================================
# Cockswitch
#================================

cockswitch () {
	local format="$1"
	local sourcepath="$storage_path/$format"

	cp -f "$sourcepath/$card_file" "$sourcepath/$token_file" ./
}

#================================
# Cockstore
#================================

cockstore () {
	local format="$1"
	local destpath="$storage_path/$format"

	cp -f "./$card_file" "./$token_file" "$destpath"
}


#================================
# Actual entrance point
#================================
 
process_optargs "${@}"

