" ~/.config/nvim/after/ftplugin/sh.vim
" ~/.config/nvim/snippets/sh/
" ~/.config/nvim/autoload/sh.vim

setlocal signcolumn=yes:1
setlocal shiftwidth=4 softtabstop=4 tabstop=4 smarttab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',min([10,line('$')]))

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/sh.vim<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call snippets#Get('sh','shebang-env.sh')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call snippets#Get('sh','sign.sh')<CR>
inoremap <buffer> :bl<Tab>   <Esc>:call snippets#Get('sh','block.sh')<CR>
