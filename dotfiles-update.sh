#!/usr/bin/env bash

arrow="$(tput setaf 4)==>$(tput sgr0)"
script_name="${arrow} $(tput bold)$(basename "$0")$(tput sgr0)"

cd "$(dirname "$0")" || exit 1

case "$(uname -s)" in
	Darwin)
		# Update Hosts: AD-BLOCK
		if command -v update-hosts &> /dev/null; then
			sudo update-hosts
		else
			echo "${script_name}: update-hosts not found, skipping..."
		fi
		# Homebrew: update packages
		brew update
		brew upgrade
		brew upgrade --cask --greedy
		# update MAS
		echo "${arrow} $(tput bold)Running MAS...$(tput sgr0)"
		mas outdated
		mas upgrade
		# clean-up
		brew autoremove
		brew cleanup
		# list packages
		brew bundle dump --force
		;;
	Linux)
		sudo apt update
		sudo apt full-upgrade
		sudo apt autoremove
		echo "${arrow} $(tput bold)Not covered by apt:$(tput sgr0) neovim (/opt/nvim-linux-x86_64), tree-sitter (~/.local/bin)"
		;;
esac

### Dotfiles: submodules and newly added files ################################

git submodule update --init --recursive
stow --restow home -t "$HOME"

### Finish ####################################################################

last_update="$(git log -1 --pretty='format:%cd' --date='format:%Y-%m-%d')"

echo "${script_name}: last commit: ${last_update}"
echo "${script_name}: this update: $(date "+%Y-%m-%d")"
[[ "$(uname -s)" == Darwin ]] && echo "${script_name}: consider using 'mo optimize' or 'mo clean'"
echo "${script_name}: finished"
