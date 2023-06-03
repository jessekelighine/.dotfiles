" ~/.config/nvim/ftplugin/matlab.vim
" ~/.config/nvim/autoload/matlab.vim
" ~/.config/nvim/snippets/matlab/

set expandtab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(%* Last Modified: *\)[^ ]*',min([10,line("$")]))

" FUNCTION KEYS: compile.
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/matlab.vim<CR>
nnoremap <buffer> <F2> :tabnew ~/.config/nvim/after/syntax/matlab.vim<CR>

" SNIPPETS: shebang, template.
inoremap <buffer> :sign<Tab> <Esc>:call my#GetSnippets('matlab','matlab_sign.m')<CR>
inoremap <buffer> :bl<Tab>   <Esc>:call my#GetSnippets('matlab','matlab_block.m')<CR>

" MAPPSINGS: useful mappings.
inoremap <buffer> ^<Tab>    ^()<Left>
nnoremap <buffer> <leader>; :call my#DelFuncCall('[a-zA-Z]','[a-zA-Z0-9_]')<CR>

" visual select "a section".
xnoremap <buffer><silent> as :call matlab#GetSection('a')<CR>
onoremap <buffer><silent> as :call matlab#GetSection('a')<CR>
xnoremap <buffer><silent> is :call matlab#GetSection('i')<CR>
onoremap <buffer><silent> is :call matlab#GetSection('i')<CR>

" Vim Slime: IDE-like key-bindings.
packadd! vim-slime
nnoremap <buffer><silent> <leader>rf :call matlab#REPL(1)<CR>
nnoremap <buffer><silent> <leader>rq :call matlab#REPL(0)<CR>
nnoremap <buffer><silent> <leader>d  m'"9yy:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>rp m'"9yiw:call vimslime#Send(@9,1)<CR>`'
nnoremap <buffer><silent> <leader>rs m'"9yiw:call vimslime#Send('size('.@9.")",1)<CR>`'
nnoremap <buffer><silent> <leader>rh m'"9yiw:call vimslime#Send("help ".@9,1)<CR>`'
nnoremap <buffer><silent> <leader>rG m'"9yG:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>pp m'"9yip:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>ss m':call matlab#GetSection('i')<CR>"9y:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>ro :call vimslime#Send("who",1)<CR>
nnoremap <buffer><silent> <leader>rr :call vimslime#Send("clc",1)<CR>
xnoremap <buffer><silent> <leader>ss m'"9y:call vimslime#Send(@9,1)<CR>`'
xnoremap <buffer><silent> <leader>rs m'"9y:call vimslime#Send("size(".@9.")",1)<CR>`'
xnoremap <buffer><silent> <leader>rp m'"9y:call vimslime#Send(@9,1)<CR>`'
