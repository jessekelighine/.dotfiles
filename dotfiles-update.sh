#!/usr/bin/env bash

arrow="$(tput setaf 4)==>$(tput sgr0)"
script_name="${arrow} $(tput bold)$(basename "$0")$(tput sgr0)"

### Update Hosts: AD-BLOCK ####################################################

sudo update-hosts

### Homebrew ##################################################################

# update packages
brew update
brew upgrade
brew upgrade --cask --greedy

# update mas
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

[[ "$1" = "interactive" ]] && {
	read -p "${script_name}: commit and push changes? (last commit: ${last_update}) [yn]: " -r commit_and_push
	if [[ $commit_and_push =~ ^[Yy]$ ]]; then
		git commit --message "Update: $(date "+%Y-%m-%d %H:%M:%S")"
		git push -u origin main
		echo "${script_name}: pushed changes to remote repository"
	fi
}

echo "${script_name}: finished"
