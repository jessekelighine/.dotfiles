" ~/.config/nvim/ftplugin/make.vim
" ~/.config/nvim/snippets/make

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/make.vim<CR>

inoremap <buffer> :tex<Tab>  <Esc>:call my#GetSnippets('make','skeleton_tex.make')<CR>
