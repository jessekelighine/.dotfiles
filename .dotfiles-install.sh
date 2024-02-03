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
#     - Adblock Plus
#     - Behind The Overlay
#     - Bypass Paywalls
#     - Markdown Viewer
#     - uBlock Origin

### Create Symlinks ###########################################################

current_shell=$(echo $SHELL | xargs basename)
[[ $current_shell == "zsh"  && ! -f .zshrc  ]] && ln -s .config/zsh/.zshrc   .
[[ $current_shell == "bash" && ! -f .bashrc ]] && ln -s .config/bash/.bashrc .

stow . && {
	printf "$0: installed with 'stow'\n"
	exit 0
}

read -p "$0: symlink directly?  [Yn] " -n 1 && printf "\n"
[[ ! $REPLY =~ ^[yY]$ ]] && printf "$0: aborted\n" && exit 0

dotlocale=$(pwd)
readarray -t files_to_link < "$dotlocale/.dotfiles-files"
for item in "${files_to_link[@]}"
do [ -e "$dotlocale/$item" ] && {
	printf "$0: linking $dotlocale/$item\n"
	ln -s "$dotlocale/$item" "$HOME/$item"
}
done

printf "$0: linked\n"
exit 0

### fzf key-bindings ##########################################################

$(brew --prefix)/opt/fzf/install
mv "$HOME/.fzf.bash" "$HOME/.config/.fzf.bash"
mv "$HOME/.fzf.zsh"  "$HOME/.config/.fzf.zsh"

### Homebrew ##################################################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install
