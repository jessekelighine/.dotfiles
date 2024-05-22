" ~/.config/nvim/ftplugin/python.vim
" ~/.config/nvim/snippets/python/
" ~/.config/nvim/autoload/python.vim

command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',10)

" GENERAL SETTINGS: disables 8-wide tab, sensible listchars.
" let g:python_recommended_style = 0
setlocal winminwidth=1
setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 smarttab
setl listchars=tab:┊\ ,trail:·,extends:»,precedes:«,nbsp:+

" FUNCTION KEYS: compile.
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/python.vim<CR>
nnoremap <buffer> <F5> :w<Enter>:! python3 %<CR>
nnoremap <buffer> <leader>; :call my#DelFuncCall('[a-zA-Z]','[a-zA-Z0-9_]')<CR>

" SNIPPETS: shebang, template.
inoremap <buffer> :bang<Tab> <Esc>:call my#GetSnippets('python','python_bang.py')<CR>
inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets('python','skeleton.py')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call my#GetSnippets('python','sign.py')<CR>

" Vim Slime: IDE-like key-bindings.
packadd! vim-slime
nnoremap <buffer><silent> <leader>rf :call py#REPL(1)<CR>
nnoremap <buffer><silent> <leader>rq :call py#REPL(0)<CR>
nnoremap <buffer><silent> <leader>d  m'"9yy:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>rp m'"9yiw:call vimslime#Send("print(".@9.")",1)<CR>`'
xnoremap <buffer><silent> <leader>ss m'"9y:call vimslime#Send(@9,1)<CR>`'
xnoremap <buffer><silent> <leader>rs m'"9y:call vimslime#Send("size(".@9.")",1)<CR>`'
xnoremap <buffer><silent> <leader>rp m'"9y:call vimslime#Send(@9,1)<CR>`'
nnoremap <buffer><silent> <leader>rG m'"9yG:call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>pp m'"9yip:call vimslime#Send(@9,1)<CR>`'
nnoremap <buffer><silent> <leader>rr :call vimslime#Send("<C-l>")<CR>
