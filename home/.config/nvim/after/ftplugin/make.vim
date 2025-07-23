" ~/.config/nvim/after/ftplugin/make.vim
" ~/.config/nvim/snippets/make

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

" LASTMOD:
let b:lastmod_pattern = '^\(#* *Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

inoremap <buffer> :tex<Tab>      <Esc>:call snippets#Get('make','tex.make')<CR>
inoremap <buffer> :quarto<Tab>   <Esc>:call snippets#Get('make','quarto.make')<CR>
inoremap <buffer> :markdown<Tab> <Esc>:call snippets#Get('make','markdown.make')<CR>
inoremap <buffer> :sign<Tab>     <Esc>:call snippets#Get('make','sign.make')<CR>
