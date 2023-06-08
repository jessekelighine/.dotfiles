" ~/.config/nvim/ftplugin/sh.vim
" ~/.config/nvim/snippets/sh/
" ~/.config/nvim/autoload/sh.vim

command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',min([10,line('$')]))
setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/sh.vim<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets('sh','shebang.sh')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call my#GetSnippets('sh','sign.sh')<CR>

inoremap <buffer><silent> {<CR> {}<Esc>i<CR><Esc><S-O>
