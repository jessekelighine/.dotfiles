#!/bin/bash

### Notes #####################################################################

# - [Backblaze](https://www.backblaze.com/cloud-backup.html)
# Fonts:
#     - [IBM Plex Mono](https://github.com/IBM/plex)
#     - [Noto CJK](https://github.com/notofonts/noto-cjk)
#     - [cwTeX](https://github.com/l10n-tw/cwtex-q-fonts)
#     - GenWanMinTJ: b2

### Homebrew ##################################################################

# install brew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## fzf ( to install key-bindings )
$(brew --prefix)/opt/fzf/install
mv -i "$HOME/.fzf.bash" "$HOME/.dotfiles/.fzf.bash"
mv -i "$HOME/.fzf.zsh"  "$HOME/.dotfiles/.fzf.zsh"

### Linking ###################################################################

ln -s "$HOME/.dotfiles/bin"             "$HOME/.local/bin"
ln -s "$HOME/.dotfiles/zsh/.zshrc"      "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/.gitconfig"      "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gnupg"          "$HOME/.gnupg"
ln -s "$HOME/.dotfiles/.password-store" "$HOME/.password-store"
ln -s "$HOME/.dotfiles/.vim"            "$HOME/.vim"
ln -s "$HOME/.dotfiles/.ssh"            "$HOME/.ssh"
ln -s "$HOME/.dotfiles/alacritty"       "$HOME/.config/alacritty"
ln -s "$HOME/.dotfiles/b2"              "$HOME/.config/b2"
ln -s "$HOME/.dotfiles/iterm2"          "$HOME/.config/iterm2"
ln -s "$HOME/.dotfiles/mpv"             "$HOME/.config/mpv"
ln -s "$HOME/.dotfiles/nvim"            "$HOME/.config/nvim"
ln -s "$HOME/.dotfiles/octave"          "$HOME/.config/octave"
ln -s "$HOME/.dotfiles/sc-im"           "$HOME/.config/sc-im"
ln -s "$HOME/.dotfiles/skim"            "$HOME/.config/skim"
ln -s "$HOME/.dotfiles/tmux"            "$HOME/.config/tmux"
ln -s "$HOME/.dotfiles/zathura"         "$HOME/.config/zathura"
ln -s "$HOME/.dotfiles/zsh"             "$HOME/.config/zsh"
ln -s "$HOME/.dotfiles/.fzf.zsh"        "$HOME/.config/.fzf.zsh"
ln -s "$HOME/.dotfiles/.bc"             "$HOME/.config/.bc"
