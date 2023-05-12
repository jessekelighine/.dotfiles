" ~/.config/nvim/ftplugin/r.vim
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r
" ~/.config/nvim/pack/main/opt/vim-slime/

" Nvim-R
let R_assign = 0
let R_disable_cmds = [ "RSendLine" ]
setlocal winminwidth=1
setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
command! -buffer -nargs=0 LastMod          :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',10)
command! -buffer -nargs=1 DatatableExplain :call system("open ~/.config/nvim/snippets/r/datatable-".<q-args>.".png")
command! -buffer -nargs=0 PipeSwitch       :call r#PipeSwitch()
let b:surround_116 ="tic()\rtoc()"

packadd matchit
let b:match_words = '\<tic\>:\<toc\>'

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
