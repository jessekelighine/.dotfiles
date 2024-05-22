#!/usr/bin/env bash

###############################################################################

current_shell=$(echo $SHELL | xargs basename)
[[ $current_shell == zsh  && -f $HOME/.zshrc  ]] && echo {$HOME,.}/.zshrc  | xargs -n 1 unlink
[[ $current_shell == bash && -f $HOME/.bashrc ]] && echo {$HOME,.}/.bashrc | xargs -n 1 unlink

###############################################################################

stow -D . && {
	printf "$0: uninstalled with 'stow'\n"
	exit 0
}

printf "$0: uninstall with 'stow' FAILED\n"
exit 1
