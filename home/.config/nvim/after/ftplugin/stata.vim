" ~/.config/nvim/after/ftplugin/stata.vim

setlocal commentstring=//\ %s

nmap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/stata.vim<CR>
nmap <buffer> <leader>pp vip''

inoremap <buffer> :c<Tab> /*  */<Left><Left><Left>
