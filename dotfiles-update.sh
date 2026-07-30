#!/usr/bin/env bash

arrow="$(tput setaf 4)==>$(tput sgr0)"
script_name="${arrow} $(tput bold)$(basename "$0")$(tput sgr0)"

### Update Hosts: AD-BLOCK ####################################################

if command -v update-hosts &> /dev/null; then
	sudo update-hosts
else
	echo "${script_name}: update-hosts not found, skipping..."
fi

### Homebrew ##################################################################

# update packages
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

### Finish ####################################################################

last_update="$(git log -1 --pretty='format:%cd' --date='format:%Y-%m-%d')"

git add .
echo "${script_name}: added changes to repository"
echo "${script_name}: last commit: ${last_update}"
echo "${script_name}: this update: $(date "+%Y-%m-%d %H:%M:%S")"
echo "${script_name}: consider using 'mo optimize' or 'mo clean'"
echo "${script_name}: finished"
