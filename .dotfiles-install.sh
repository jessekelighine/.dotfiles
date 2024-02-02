#!/usr/bin/env bash

### Notes #####################################################################

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

stow .

exit 0

### Homebrew ##################################################################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

## fzf ( to install key-bindings )
$(brew --prefix)/opt/fzf/install
# mv -i "$HOME/.fzf.bash" "$HOME/.dotfiles/.fzf.bash"
# mv -i "$HOME/.fzf.zsh"  "$HOME/.dotfiles/.fzf.zsh"
