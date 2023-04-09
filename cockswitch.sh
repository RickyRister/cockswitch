#!/bin/bash

usage_info () {
	echo ""
	echo "Switch the current card files in the cockatrice folder"
	echo "Usage: cockswitch <Format>	Switch the current card files to format"
	echo ""
	echo "Card files for each format should be stored in storage/<format> inside the Cockatrice folder"
	echo ""
	echo "Options:"
	echo "-s FORMAT	saves the current cards as the format"
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

do_switch=true
do_store=false
do_new=false
do_delete=false

process_optargs () {
  	local OPTIND
  	while getopts "snd" option; do
  	 	case $option in
   	   		s)
   	     		do_store=true
   	     		do_switch=false ;;
   	   		n)
   	     		do_new=true
   	     		do_switch=false ;;
   	   		d)
   	     		do_delete=true ;;
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

	# run appropriate command
 	if [ $do_new = 'true' ]; then make_format "${@}"; fi
 	if [ $do_store = 'true' ]; then store_format "${@}"; fi
 	if [ $do_switch = 'true' ]; then switch_format "${@}"; fi
 	if [ $do_delete = 'true' ]; then delete_format "${@}"; fi
}

#================================
# Create format
#================================

make_format () {
	local format="$1"
	local destpath="$storage_path/$format"

	mkdir "$destpath"
}

#================================
# Switch format
#================================

switch_format () {
	local format="$1"
	local sourcepath="$storage_path/$format"

	cp -f "$sourcepath/$card_file" "$sourcepath/$token_file" ./
}

#================================
# Store format
#================================

store_format () {
	local format="$1"
	local destpath="$storage_path/$format"

	cp -f "./$card_file" "./$token_file" "$destpath"
}

#================================
# Delete format
#================================

delete_format () {
	local format="$1"
	local destpath="$storage_path/$format"

	rm -r "$destpath"
}


#================================
# Actual entrance point
#================================
 
process_optargs "${@}"

