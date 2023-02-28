" ~/.config/nvim/ftplugin/c.vim

" complie and run the code
nnoremap <F5> :w<Enter>:! gcc -o "%:r" % && ./"%:r"<CR>
