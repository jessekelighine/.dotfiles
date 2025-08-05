" ~/.config/nvim/after/plugin/surround.vim
" ~/.config/nvim/autoload/surround.vim

set matchpairs+=（:）
set matchpairs+=「:」
set matchpairs+=『:』
set matchpairs+=《:》
set matchpairs+=【:】
set matchpairs+=〈:〉
set matchpairs+=“:”

nnoremap <silent> dm <Cmd>call surround#Delete()<CR>
