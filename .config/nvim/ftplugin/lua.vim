" ~/.config/nvim/ftplugin/lua.vim
" ~/.config/nvim/snippets/lua

" FUNCTION KEYS:
nnoremap <buffer><silent> <F1> :tabnew ~/.config/nvim/ftplugin/lua.vim<CR>

" SNIPPETS:
inoremap <buffer> :bl<Tab> <Esc>:call my#GetSnippets("lua","block.lua")<CR>
