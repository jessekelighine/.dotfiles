#!/usr/bin/env bash

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update -v
brew upgrade

# update Cask
outdated_casks=$(brew outdated --cask --greedy --verbose)
[[ -n "$outdated_casks" ]] && {
	echo "$outdated_casks"
	read -r -p "$(tput bold)>>> Update Casks? [Yn]: $(tput sgr0)"
	[[ "$REPLY" == Y ]] && {
		echo "$outdated_casks" | \
			grep -v '(latest)' | \
			awk '{ print $1 }' | \
			xargs brew reinstall --cask
	}
}

# update mas
mas outdated
mas upgrade

# clean-up
brew autoremove -v
brew cleanup -v

# list packages
brew bundle dump --force

### Date and Git Add ##########################################################

printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
