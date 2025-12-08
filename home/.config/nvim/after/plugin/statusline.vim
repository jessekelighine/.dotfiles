" ~/.config/nvim/after/plugin/statusline.vim
" ~/.config/nvim/autoload/statusline.vim

call statusline#Setup()
command! -nargs=0 StatuslineReload call statusline#Set()
nnoremap <silent> <CR> :StatuslineReload<CR>:nohlsearch<CR>:echo<CR>
