" ~/.config/nvim/after/ftplugin/cpp.vim
" ~/.config/nvim/lua/cmp/cpp.lua
" ~/.config/nvim/snippets/cpp/

setlocal commentstring=//\ %s
setlocal shiftwidth=4 softtabstop=4 tabstop=4 smarttab

nnoremap <buffer> <F5>      <Cmd>call cpp#Compile()<CR>
nnoremap <buffer> <F6>      <Cmd>call cpp#Compile()<CR>
nnoremap <buffer> <leader>; <Cmd>call funcargs#DeleteFunction('[a-zA-Z]','[:a-zA-Z0-9_]')<CR>
