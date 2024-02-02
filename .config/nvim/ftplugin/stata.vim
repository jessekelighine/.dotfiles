" ~/.config/nvim/ftplugin/stata.vim

setlocal commentstring=//\ %s

nmap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/stata.vim<CR>
nmap <buffer> <leader>pp vip''

inoremap <buffer> :c<Tab> /*  */<Left><Left><Left>
inoremap <buffer> {<CR> {<CR>}<Esc><S-O><Tab>
