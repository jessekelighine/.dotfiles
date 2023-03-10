#!/usr/bin/env bash

# ~/.config/nvim/pack/color/start (colorscheme)
git submodule add https://github.com/jessekelighine/miramare     color/start/miramare

# ~/.config/nvim/pack/main/start
git submodule add https://github.com/jessekelighine/vindent.vim  main/start/vindent.vim
git submodule add https://github.com/jessekelighine/vim-peekaboo main/start/vim-peekaboo
git submodule add https://github.com/tpope/vim-surround          main/start/vim-surround
git submodule add https://github.com/tpope/vim-commentary        main/start/vim-commentary
git submodule add https://github.com/tpope/vim-repeat            main/start/vim-repeat
git submodule add https://github.com/tpope/vim-vinegar           main/start/vim-vinegar
git submodule add https://github.com/junegunn/fzf.vim            main/start/fzf.vim
git submodule add https://github.com/junegunn/vim-easy-align     main/start/vim-easy-align
git submodule add https://github.com/jalvesaq/Nvim-R             main/start/Nvim-R
git submodule add https://github.com/mbbill/undotree             main/start/undotree

# ~/.config/nvim/pack/main/opt
git submodule add https://github.com/junegunn/goyo.vim           main/opt/goyo.vim
