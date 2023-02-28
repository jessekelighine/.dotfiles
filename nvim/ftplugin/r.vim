" ~/.config/nvim/ftplugin/r.vim
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r
" ~/.config/nvim/pack/main/opt/vim-slime/

" Nvim-R
let R_assign = 0
let R_disable_cmds = [ "RSendLine" ]

" packadd vim-slime
setlocal winminwidth=1
setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',10)

" Utilities:
xnoremap <buffer><silent> as :call r#GetSection('a')<CR>
xnoremap <buffer><silent> is :call r#GetSection('i')<CR>
onoremap <buffer><silent> as :call r#GetSection('a')<CR>
onoremap <buffer><silent> is :call r#GetSection('i')<CR>

" Snippets: snippets.
inoremap <buffer> :sign<Tab>  <Esc>:call my#GetSnippets("r","sign.R",1,1,0)<CR>
inoremap <buffer> :bl<Tab>    <Esc>:call my#GetSnippets("r","block.R")<CR>
inoremap <buffer> :qui<Tab>   <Esc>:call my#GetSnippets("r","qui.R",1,1,0)<CR>
inoremap <buffer> :lib<Tab>   <Esc>:call my#GetSnippets("r","library.R")<CR>
inoremap <buffer> :ggs<Tab>   <Esc>:call my#GetSnippets("r","ggsave.R")<CR>
inoremap <buffer> :ggch<Tab>  <Esc>:call my#GetSnippets("r","ggplotChinese.R")<CR>
inoremap <buffer> :se<Tab>    <Esc>:call my#GetSnippets("r","robust.R")<CR>
inoremap <buffer> :log<Tab>   <Esc>:call my#GetSnippets("r","logfile.R")<CR>
inoremap <buffer> :cl<Tab>    <Esc>:call my#GetSnippets("r","consolelog.R")<CR>
inoremap <buffer> :mode<Tab>  <Esc>:call my#GetSnippets("r","modus.R")<CR>
inoremap <buffer> :rm<Tab>    <Esc>:call my#GetSnippets("r","rm.R")<CR>

" Mappings: mappings.
nnoremap <buffer><silent> <F1>       :tabnew ~/.config/nvim/ftplugin/r.vim<CR>
nnoremap <buffer><silent> <F2>       :tabnew ~/.config/nvim/after/syntax/r.vim<CR>
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab',"%>%")<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR',"%>%")<CR>
nnoremap <buffer><silent> <leader>;  :call my#DelFuncCall('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
inoremap <buffer><silent> {<CR>      {}<esc>i<CR><esc><S-O>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>

" Vim Slime: IDE-like key-bindings.
" nnoremap <buffer><silent> <leader>v       :call vimslime#tmux_vars()<CR>
" xnoremap <buffer><silent> <leader>ss   "9y:call vimslime#send_to_pane(@9)<CR>
" nnoremap <buffer><silent> <leader>pp "9yip:call vimslime#send_to_pane(@9)<CR>
" nnoremap <buffer><silent> <leader>d   "9yy:call vimslime#send_to_pane(@9)<CR>
" nnoremap <buffer><silent> <leader>rr      :call vimslime#send_to_pane("<C-l>")<CR>
" nnoremap <buffer><silent> <leader>ro      :call vimslime#send_to_pane("ls()\n")<CR>
" nnoremap <buffer><silent> <leader>rp "9yiw:call vimslime#send_to_pane("print(".@9.")\n")<CR>
" nnoremap <buffer><silent> <leader>rg "9yiw:call vimslime#send_to_pane("glimpse(".@9.")\n")<CR>
" nnoremap <buffer><silent> <leader>rh "9yiw:call vimslime#send_to_pane("?".@9."\n")<CR>
" nnoremap <buffer><silent> <leader>rs "9yiw:call vimslime#send_to_pane("summary(".@9.")\n")<CR>
" nnoremap <buffer><silent> <leader>rq      :call vimslime#send_to_pane("<C-D>n\n<C-D>")<CR>
" nnoremap <buffer><silent> <leader>qq      :call vimslime#send_to_pane("q")<CR>
