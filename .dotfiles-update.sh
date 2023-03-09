#!/bin/bash

# brew packages
brew upgrade
brew autoremove
brew cleanup
brew leaves > .brew_list
brew list --cask > .brew_cask

# LaTeX packages
tlmgr list --only-installed > nvim/pack/lang/opt/tex/PACKAGES.txt

printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
