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

script_name="$(tput bold)$(basename "$0")$(tput sgr0)"
last_update="$(git log -1 --pretty='format:%cd' --date='format:%Y-%m-%d')"

git add .

read -p "${script_name}: commit and push changes? (last commit: ${last_update}) [yn]: " -r commit_and_push
if [[ $commit_and_push =~ ^[Yy]$ ]]; then
	git commit --message "Update: $(date "+%Y-%m-%d %H:%M:%S")"
	git push -u origin main
	echo "${script_name}: pushed changes to remote repository"
fi

echo "${script_name}: finished"
