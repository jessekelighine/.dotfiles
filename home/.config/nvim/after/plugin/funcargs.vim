" ~/.config/nvim/after/plugin/funcargs.vim
" ~/.config/nvim/autoload/funcargs.vim

xnoremap <silent> ia <Esc>:call funcargs#SelectArgument("i")<CR>
xnoremap <silent> aa <Esc>:call funcargs#SelectArgument("a")<CR>
onoremap <silent> ia <Cmd> call funcargs#SelectArgument("i")<CR>
onoremap <silent> aa <Cmd> call funcargs#SelectArgument("a")<CR>
