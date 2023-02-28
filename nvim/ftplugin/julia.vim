" ~/.config/nvim//ftplugin/julia.vim
" ~/.config/nvim/autoload/julia.vim

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/julia.vim<CR>
nnoremap <buffer> <F5> :call julia#Compile()<CR>

" IDE Features: 
xnoremap <buffer> <leader>ss y<C-w>wpa<CR><C-\><C-n><C-w>p
nnoremap <buffer> <leader>rr <C-w>wa<C-l><C-\><C-n><C-w>p
