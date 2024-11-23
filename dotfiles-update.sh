#!/usr/bin/env bash

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update
brew upgrade
brew upgrade --cask --greedy

# update mas
echo "$(tput setaf 4)==>$(tput sgr0) $(tput bold)Running MAS...$(tput sgr0)"
mas outdated
mas upgrade

# clean-up
brew autoremove
brew cleanup

# list packages
brew bundle dump --force

### Finish ####################################################################

git add .

cat << EOF
$(tput bold)$(basename $0)$(tput sgr0): Updated.
EOF
