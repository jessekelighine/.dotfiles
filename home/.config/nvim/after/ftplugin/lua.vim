" ~/.config/nvim/after/ftplugin/lua.vim
" ~/.config/nvim/snippets/lua

" SNIPPETS:
inoremap <buffer> :bl<Tab> <Esc>:call snippets#Get("lua", "block.lua")<CR>
nnoremap <buffer> <leader>; <Cmd>call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9_.]')<CR>
