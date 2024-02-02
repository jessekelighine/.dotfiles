#!/usr/bin/env bash

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update
brew upgrade --verbose
brew upgrade --cask --greedy --verbose

# update mas
echo "==> $(tput bold)Running MAS$(tput sgr0)"
mas outdated
mas upgrade

# clean-up
brew autoremove -v
brew cleanup -v

# list packages
brew bundle dump --force

### Date and Git Add ##########################################################

# printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
