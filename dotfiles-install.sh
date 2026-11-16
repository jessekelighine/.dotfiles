#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine.com                                                  #
#                                                                             #
# Last Modified: 2026-11-16                                                   #
###############################################################################

# - Fonts:
#     - [cwTeX](https://github.com/l10n-tw/cwtex-q-fonts)
#     - [jf-openhuninn-2.0](https://github.com/justfont/open-huninn-font)
#     - [Garamond Math](https://github.com/YuanshengZhao/Garamond-Math)
#     - GenWanMinTJ: b2
# - [Okular](https://invent.kde.org/packaging/homebrew-kde/)
# - [Backblaze](https://www.backblaze.com/cloud-backup.html)
# - Firefox Add-ons:
#     - Adblock Plus
#     - Behind The Overlay
#     - Bypass Paywalls
#     - Markdown Viewer
#     - uBlock Origin
#     - Vimium: put `map s passNextKey` so original youtube keybindings
#       can be used.

cd "$(dirname "$0")" || exit 1

case "$(uname -s)" in
	Darwin)
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew bundle install
		defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
		defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
		defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false && killall Finder
		# defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0; killall Dock
		;;
	Linux)
		command -v stow >/dev/null || {
			printf "%s: install stow first: sudo apt install stow\n" "$0"
			exit 1
		}
		# Distro defaults that would block stow: move aside (once) as *.distro-default
		for f in .bashrc .tmux.conf; do
			[[ -f "$HOME/$f" && ! -L "$HOME/$f" ]] && mv -v "$HOME/$f" "$HOME/$f.distro-default"
		done
		;;
esac

### Submodules (confucius-said, del, zsh plugins, ...) ########################

git submodule update --init --recursive

### Symlinking ################################################################

stow --no-folding home -t "$HOME" && {
	printf "%s: installed with 'stow'\n" "$0"
	exit 0
}

printf "%s: failed to install with 'stow'\n" "$0"
exit 1
