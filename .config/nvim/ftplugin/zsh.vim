" ~/.config/nvim/ftplugin/zsh.vim
" ~/.config/nvim/snippets/zsh

command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',( line('$')<10 ? line('$') : 10 ))
setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/zsh.vim<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets('zsh','shebang.zsh')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call my#GetSnippets('zsh','sign.zsh')<CR>
