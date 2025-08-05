" ~/.config/nvim/after/ftplugin/make.vim
" ~/.config/nvim/lua/cmp/make.lua
" ~/.config/nvim/snippets/make/

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

" LASTMOD:
let b:lastmod_pattern = '^\(#* *Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)
