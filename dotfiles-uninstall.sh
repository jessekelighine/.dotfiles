#!/usr/bin/env bash

stow --delete home -t "$HOME" && {
	printf "$0: uninstalled with 'stow'\n"
	exit 0
}

printf "$0: uninstall with 'stow' FAILED\n"
exit 1
