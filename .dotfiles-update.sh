#!/usr/bin/env bash

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update -v
brew upgrade -v
brew outdated --cask --greedy --verbose | \
	grep -v '(latest)' | \
	awk '{print $1}' | \
	xargs brew reinstall --cask -v

# clean-up
brew autoremove -v
brew cleanup -v

# list packages
brew leaves > .brew_list
brew list --cask > .brew_cask

### Date and Git Add ##########################################################

printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
