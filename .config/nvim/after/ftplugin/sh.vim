" ~/.config/nvim/after/ftplugin/sh.vim
" ~/.config/nvim/snippets/sh/
" ~/.config/nvim/autoload/sh.vim

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',min([10,line('$')]))

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/sh.vim<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets('sh','shebang-env.sh')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call my#GetSnippets('sh','sign.sh')<CR>
inoremap <buffer> :bl<Tab>   <Esc>:call my#GetSnippets('sh','block.sh')<CR>
