" ~/.config/nvim/after/ftplugin/make.vim
" ~/.config/nvim/snippets/make

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',min([10,line('$')]))

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/make.vim<CR>

inoremap <buffer> :tex<Tab>      <Esc>:call my#GetSnippets('make','tex.make')<CR>
inoremap <buffer> :markdown<Tab> <Esc>:call my#GetSnippets('make','markdown.make')<CR>
inoremap <buffer> :sign<Tab>     <Esc>:call my#GetSnippets('make','sign.make')<CR>