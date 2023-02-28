" ~/.config/nvim/ftplugin/python.vim
" ~/.config/nvim/snippets/python/

" GENERAL SETTINGS: disables 8-wide tab, sensible listchars.
" let g:python_recommended_style = 0
packadd vim-slime
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

" Vim Slime: IDE-like key-bindings.
nnoremap <buffer><silent> <leader>v       :call vimslime#tmux_vars()<CR>
xnoremap <buffer><silent> <leader>ss   "9y:call vimslime#send_to_pane(@9."\n")<CR>
nnoremap <buffer><silent> <leader>pp "9yip:call vimslime#send_to_pane(@9."\n")<CR>
nnoremap <buffer><silent> <leader>d   "9yy:call vimslime#send_to_pane(@9."\n")<CR>
nnoremap <buffer><silent> <leader>rr      :call vimslime#send_to_pane("<C-l>")<CR>
nnoremap <buffer><silent> <leader>rp "9yiw:call vimslime#send_to_pane("print(".@9.")\n")<CR>
