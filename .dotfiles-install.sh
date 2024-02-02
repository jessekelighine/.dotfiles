#!/usr/bin/env bash

### Notes #####################################################################

# 2024-02-02
#
# - Fonts:
#     - [IBM Plex Mono](https://github.com/IBM/plex)
#     - [Noto CJK](https://github.com/notofonts/noto-cjk)
#     - [cwTeX](https://github.com/l10n-tw/cwtex-q-fonts)
#     - [jf-openhuninn-2.0](https://github.com/justfont/open-huninn-font)
#     - [LXGW WenKai / 霞鹜文楷](https://github.com/lxgw/LxgwWenKai)
#     - GenWanMinTJ: b2
# - [Okular](https://invent.kde.org/packaging/homebrew-kde/)
# - [Backblaze](https://www.backblaze.com/cloud-backup.html)
# - Firefox Add-ons:
#     - Adblock Plus - free ad blocker
#     - Behind The Overlay
#     - Bypass Paywalls
#     - Markdown Viewer
#     - uBlock Origin

### Create Symlinks ###########################################################

current_shell=$(echo $SHELL | xargs basename)
[[ $current_shell == "zsh"  ]] && ln -s .config/zsh/.zshrc   .
[[ $current_shell == "bash" ]] && ln -s .config/bash/.bashrc .

stow . && exit 0

read -p ">>> command 'stow' not avaible, symlink directly? [Yn] " -n 1
[[ ! $REPLY =~ ^[yY]$ ]] && printf "\n>>> aborted\n" && exit 0

[ -f .zshrc  ] && ln -s "$HOME/.dotfiles/.zshrc"  "$HOME/.zshrc"
[ -f .bashrc ] && ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.R"                "$HOME/.R"
ln -s "$HOME/.dotfiles/.latexmkrc"        "$HOME/.latexmkrc"
ln -s "$HOME/.dotfiles/.gitconfig"        "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gnupg"            "$HOME/.gnupg"
ln -s "$HOME/.dotfiles/.password-store"   "$HOME/.password-store"
ln -s "$HOME/.dotfiles/.vim"              "$HOME/.vim"
ln -s "$HOME/.dotfiles/.ssh"              "$HOME/.ssh"
ln -s "$HOME/.dotfiles/.screenrc"         "$HOME/.screenrc"
ln -s "$HOME/.dotfiles/.hammerspoon"      "$HOME/.hammerspoon"
ln -s "$HOME/.dotfiles/.local/bin"        "$HOME/.local/bin"
ln -s "$HOME/.dotfiles/.config/alacritty" "$HOME/.config/alacritty"
ln -s "$HOME/.dotfiles/.config/b2"        "$HOME/.config/b2"
ln -s "$HOME/.dotfiles/.config/iterm2"    "$HOME/.config/iterm2"
ln -s "$HOME/.dotfiles/.config/mpv"       "$HOME/.config/mpv"
ln -s "$HOME/.dotfiles/.config/nvim"      "$HOME/.config/nvim"
ln -s "$HOME/.dotfiles/.config/octave"    "$HOME/.config/octave"
ln -s "$HOME/.dotfiles/.config/sc-im"     "$HOME/.config/sc-im"
ln -s "$HOME/.dotfiles/.config/skim"      "$HOME/.config/skim"
ln -s "$HOME/.dotfiles/.config/tmux"      "$HOME/.config/tmux"
ln -s "$HOME/.dotfiles/.config/zathura"   "$HOME/.config/zathura"
ln -s "$HOME/.dotfiles/.config/zsh"       "$HOME/.config/zsh"
ln -s "$HOME/.dotfiles/.config/.fzf.zsh"  "$HOME/.config/.fzf.zsh"
ln -s "$HOME/.dotfiles/.config/.fzf.bash" "$HOME/.config/.fzf.bash"
ln -s "$HOME/.dotfiles/.config/.bc"       "$HOME/.config/.bc"

printf "\n>>> linked\n"
exit 0

### Homebrew ##################################################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

## fzf ( to install key-bindings )
$(brew --prefix)/opt/fzf/install
# mv -i "$HOME/.fzf.bash" "$HOME/.dotfiles/.fzf.bash"
# mv -i "$HOME/.fzf.zsh"  "$HOME/.dotfiles/.fzf.zsh"
