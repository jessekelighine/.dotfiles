#!/bin/bash

# merge two files
mergefile () {
	local ext

	[ $# -ne 2 ] && echo "Error: Need exactly two args." && return 1

	[[ ! -r $1 || ! -r $2 ]] && echo "Error: One of the files is not readable." && return 1

	[[ ${1##*/} =~ '.' || ${2##*/} =~ '.' ]] && {
		[ ${1##*.} != ${2##*.} ] && echo "Error: Files must have same extension." && return 1
		ext=.${1##*.}
	}

	touch "temp_file$ext" # use empty file as the 'root' of the merge
	git merge-file "$1" "temp_file$ext" "$2" # will write to file 1
	rm "temp_file$ext"
}
