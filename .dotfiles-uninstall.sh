#!/usr/bin/env bash

current_shell=$(echo $SHELL | xargs basename)
[[ $current_shell == zsh  && -f $HOME/.zshrc  ]] && echo {$HOME,.}/.zshrc  | xargs -n 1 unlink
[[ $current_shell == bash && -f $HOME/.bashrc ]] && echo {$HOME,.}/.bashrc | xargs -n 1 unlink

stow -D . && {
	printf "$0: uninstalled with 'stow'\n"
	exit 0
}

read -p "$0: unlink directly?  [Yn] " -n 1 && printf "\n"
[[ ! $REPLY =~ ^[yY]$ ]] && printf "$0: aborted\n" && exit 0

dotlocale=$(pwd)
readarray -t files_to_link < "$dotlocale/.dotfiles-files"
for item in "${files_to_link[@]}"
do [ -e "$HOME/$item" ] && {
	printf "$0: unlinking $HOME/$item\n"
	unlink "$HOME/$item"
}
done

printf "$0: unlinked\n"
exit 0
