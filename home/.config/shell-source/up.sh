#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Description: Quickly traverse up the current working path.                  #
# Original Author: Shannon Moeller <me@shannonmoeller.com>                    #
# Modified: Jesse Chieh Chen <https://jessekelighine.com>                     #
#                                                                             #
# Last Modified: 2025-07-16                                                   #
###############################################################################

__updir () {
	[[ "$1" == "/" || -z "$1" || -z "$2" ]] && return

	local parent_dir_full; parent_dir_full="$(dirname "$1")"
	local parent_dir_base; parent_dir_base="$(basename "$parent_dir_full")"
	local pattern; pattern="$(basename "$2")"

	[[ -z "$parent_dir_base" || -z "$pattern" ]] && return

	[[ "$parent_dir_base" == "$pattern"* ]] && {
		echo "$parent_dir_full"
		return
	}

	__updir "$parent_dir_full" "$2"
}

__upnum () {
	[[ -z "$1" || -z "$2" || ! "$2" =~ ^[0-9]+$ ]] && return

	local parent_dir; parent_dir="$1"
	local number; number="$2"

	while (( number-- ))
	do
		parent_dir="$(dirname "$parent_dir")"
	done

	echo "$parent_dir"
}

up () {
	# GO UP ONE LEVEL IF NO ARGUMENTS:
	(( ! $# )) && {
		cd .. && return || return
	}

	local updir

	# GO UP TO MATCHED DIRECTORY:
	updir="$(__updir "$PWD" "$1")"
	[[ -d "$updir" ]] && {
		cd "$updir" && return || return
	}

	# GO UP NUMBER DIRECTORIES:
	updir="$(__upnum "$PWD" "$1")"
	[[ -d "$updir" ]] && {
		cd "$updir" && return || return
	}

	# USAGE:
	local command; command="$(tput bold)up$(tput sgr0)"
	local usage; usage="$(tput bold)USAGE$(tput sgr0)"
	local description; description="$(tput bold)DESCRIPTION$(tput sgr0)"
	cat <<EOF
$usage: $command [directory|number]
$description:
	Change directory to a parent directory depending on the argument: 
	1. go to the first parent directory whose name starts with [directory];
	2. go up [number] directories;
	3. go up one directory if no argument is provided.
EOF
}
