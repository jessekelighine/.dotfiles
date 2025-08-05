" ~/.config/nvim/after/ftplugin/bib.vim
" ~/.config/nvim/lua/cmp/bib.lua
" ~/.config/nvim/snippets/bib/

command! -buffer -range FormatEntries :'<,'>!biber-format-pipe
setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab
