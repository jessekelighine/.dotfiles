#!/bin/bash

### Notes #####################################################################

# repo path
dotfiles="$HOME/.dotfiles"

# - [Backblaze](https://www.backblaze.com/cloud-backup.html)

### Homebrew ##################################################################

# install brew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# TeX Live
# [website](https://www.tug.org/mactex/morepackages.html)
brew install --cask basictex

## fzf ( to install key-bindings )
$(brew --prefix)/opt/fzf/install
mv "$HOME/.fzf.bash" "$dotfiles/.fzf.bash"
mv "$HOME/.fzf.zsh"  "$dotfiles/.fzf.zsh"

# R
brew install r

### Linking ###################################################################

ln -s "$dotfiles/.gnupg"          "$HOME/.gnupg"
ln -s "$dotfiles/.password-store" "$HOME/.password-store"
ln -s "$dotfiles/.vim"            "$HOME/.vim"
ln -s "$dotfiles/.ssh"            "$HOME/.ssh"
ln -s "$dotfiles/bin"             "$HOME/.local/bin"
ln -s "$dotfiles/alacritty"       "$HOME/.config/alacritty"
ln -s "$dotfiles/b2"              "$HOME/.config/b2"
ln -s "$dotfiles/iterm2"          "$HOME/.config/iterm2"
ln -s "$dotfiles/mpv"             "$HOME/.config/mpv"
ln -s "$dotfiles/nvim"            "$HOME/.config/nvim"
ln -s "$dotfiles/octave"          "$HOME/.config/octave"
ln -s "$dotfiles/sc-im"           "$HOME/.config/sc-im"
ln -s "$dotfiles/skim"            "$HOME/.config/skim"
ln -s "$dotfiles/tmux"            "$HOME/.config/tmux"
ln -s "$dotfiles/zathura"         "$HOME/.config/zathura"
ln -s "$dotfiles/zsh"             "$HOME/.config/zsh"
ln -s "$dotfiles/.fzf.zsh"        "$HOME/.config/.fzf.zsh"
ln -s "$dotfiles/.bc"             "$HOME/.config/.bc"
ln -s "$dotfiles/zsh/.zshrc"      "$HOME/.zshrc"
