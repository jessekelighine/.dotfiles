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
[[ $current_shell == "zsh"  && ! -f .zshrc  ]] && ln -s .config/zsh/.zshrc   .
[[ $current_shell == "bash" && ! -f .bashrc ]] && ln -s .config/bash/.bashrc .

stow . && printf "$0: installed with 'stow'\n" && exit 0
read -p "$0: symlink directly?  [Yn] " -n 1
[[ ! $REPLY =~ ^[yY]$ ]] && printf "\n$0: aborted\n" && exit 0

dot_locale=$(pwd)
[ -f .zshrc  ] && ln -s "${dot_locale}/.zshrc"  "$HOME/.zshrc"
[ -f .bashrc ] && ln -s "${dot_locale}/.bashrc" "$HOME/.bashrc"
ln -s "${dot_locale}/.R"                "$HOME/.R"
ln -s "${dot_locale}/.latexmkrc"        "$HOME/.latexmkrc"
ln -s "${dot_locale}/.gitconfig"        "$HOME/.gitconfig"
ln -s "${dot_locale}/.gnupg"            "$HOME/.gnupg"
ln -s "${dot_locale}/.password-store"   "$HOME/.password-store"
ln -s "${dot_locale}/.vim"              "$HOME/.vim"
ln -s "${dot_locale}/.ssh"              "$HOME/.ssh"
ln -s "${dot_locale}/.screenrc"         "$HOME/.screenrc"
ln -s "${dot_locale}/.hammerspoon"      "$HOME/.hammerspoon"
ln -s "${dot_locale}/.local/bin"        "$HOME/.local/bin"
ln -s "${dot_locale}/.config/alacritty" "$HOME/.config/alacritty"
ln -s "${dot_locale}/.config/b2"        "$HOME/.config/b2"
ln -s "${dot_locale}/.config/iterm2"    "$HOME/.config/iterm2"
ln -s "${dot_locale}/.config/mpv"       "$HOME/.config/mpv"
ln -s "${dot_locale}/.config/nvim"      "$HOME/.config/nvim"
ln -s "${dot_locale}/.config/octave"    "$HOME/.config/octave"
ln -s "${dot_locale}/.config/sc-im"     "$HOME/.config/sc-im"
ln -s "${dot_locale}/.config/skim"      "$HOME/.config/skim"
ln -s "${dot_locale}/.config/tmux"      "$HOME/.config/tmux"
ln -s "${dot_locale}/.config/zathura"   "$HOME/.config/zathura"
ln -s "${dot_locale}/.config/zsh"       "$HOME/.config/zsh"
ln -s "${dot_locale}/.config/.fzf.zsh"  "$HOME/.config/.fzf.zsh"
ln -s "${dot_locale}/.config/.fzf.bash" "$HOME/.config/.fzf.bash"
ln -s "${dot_locale}/.config/.bc"       "$HOME/.config/.bc"

printf "\n$0: linked\n"
exit 0

### fzf key-bindings ##########################################################

$(brew --prefix)/opt/fzf/install
mv "$HOME/.fzf.bash" "$HOME/.config/.fzf.bash"
mv "$HOME/.fzf.zsh"  "$HOME/.config/.fzf.zsh"

### Homebrew ##################################################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install
