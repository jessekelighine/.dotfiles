#!/bin/bash

### Homebrew ##################################################################

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## TeX Live
# [website](https://www.tug.org/mactex/morepackages.html)
brew install --cask basictex

## fzf ( to install key-bindings )
$(brew --prefix)/opt/fzf/install
mv "$HOME/.fzf.bash" "$HOME/.dotfiles/.fzf.bash"
mv "$HOME/.fzf.zsh"  "$HOME/.dotfiles/.fzf.zsh"

## R
brew install r

### Linking ###################################################################

ln -s ~/.dotfiles/.bc        ~/.config/.bc
ln -s ~/.dotfiles/alacritty  ~/.config/alacritty
ln -s ~/.dotfiles/b2         ~/.config/b2
ln -s ~/.dotfiles/bash       ~/.config/bash
ln -s ~/.dotfiles/bin        ~/.config/bin
ln -s ~/.dotfiles/iterm2     ~/.config/iterm2
ln -s ~/.dotfiles/mpv        ~/.config/mpv
ln -s ~/.dotfiles/nvim       ~/.config/nvim
ln -s ~/.dotfiles/octave     ~/.config/octave
ln -s ~/.dotfiles/sc-im      ~/.config/sc-im
ln -s ~/.dotfiles/skim       ~/.config/skim
ln -s ~/.dotfiles/tmux       ~/.config/tmux
ln -s ~/.dotfiles/zathura    ~/.config/zathura
ln -s ~/.dotfiles/zsh        ~/.config/zsh

ln -s ~/.dotfiles/zsh/.zshrc     ~/.zshrc
ln -s ~/.dotfiles/gnupg          ~/.gnupg
ln -s ~/.dotfiles/password-store ~/.password-store
ln -s ~/.dotfiles/vim            ~/.vim

### Others ####################################################################

# - [Backblaze](https://www.backblaze.com/cloud-backup.html)
