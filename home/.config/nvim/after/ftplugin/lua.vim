" ~/.config/nvim/after/ftplugin/lua.vim
" ~/.config/nvim/snippets/lua

setlocal signcolumn=yes:1

" FUNCTION KEYS:
nnoremap <buffer><silent> <F1> :tabnew ~/.config/nvim/after/ftplugin/lua.vim<CR>

" SNIPPETS:
inoremap <buffer> :bl<Tab> <Esc>:call my#GetSnippets("lua","block.lua")<CR>
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9_.]')<CR>

nmap dsi ]-dd<C-O>[-dd<C-O>=ii<C-O>
