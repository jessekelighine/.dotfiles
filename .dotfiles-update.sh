#!/usr/bin/env bash

set -e

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update
brew upgrade
brew outdated --cask --greedy --verbose |\
	grep -v '(latest)' |\
	awk '{print $1}' |\
	xargs brew reinstall --cask

# clean-up
brew autoremove
brew cleanup

# list packages
brew leaves > .brew_list
brew list --cask > .brew_cask

### Date and Git Add ##########################################################

printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
