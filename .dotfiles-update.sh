#!/usr/bin/env bash

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
# brew update
# brew upgrade --verbose
# brew upgrade --cask --greedy --verbose

# update mas
echo "==> $(tput bold)Running MAS$(tput sgr0)"
mas outdated
mas upgrade

# clean-up
brew autoremove -v
brew cleanup -v

# list packages
brew bundle dump --force

### Finish ####################################################################

git add .

cat << EOF
$(tput bold)$0$(tput sgr0): Update finished. Check following files manually:
	- .stow-local-ignore 
	- .dotfiles-files
	- .gitignore
EOF
