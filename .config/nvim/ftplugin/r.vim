" ~/.config/nvim/ftplugin/r.vim
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r

" Nvim-R
let R_assign = 0
" let R_disable_cmds = [ "RSendLine" ]

" Settings:
packadd matchit
setlocal winminwidth=1
setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
setlocal foldmethod=marker
let b:match_words  = '\<tic\>:\<toc\>'
let b:surround_116 = "tic()\rtoc()"
let b:surround_84  = "timer$tic()\rtimer$toc()"
let b:surround_112 = "pdf(file=\"\")\rdev.off()"
let b:r_pipe_type  = "|>"
command! -buffer -nargs=0 LastMod    :call my#LastMod('^\(#* *Last Modified: *\)[^ ]*',10)
command! -buffer -nargs=0 PipeSwitch :let b:r_pipe_type = b:r_pipe_type=='%>%' ? '|>' : '%>%' | echom ' Pipe: ' . b:r_pipe_type
command! -buffer -nargs=1 -complete=custom,r#DatatableExplainComplete DatatableExplain :call r#DatatableExplain(<q-args>)
command! -buffer -nargs=0 FindSection   :call r#FindSection()

" Snippets:
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
inoremap <buffer> :timer<Tab> <Esc>:call my#GetSnippets("r","timer.R")<CR>
inoremap <buffer> :curry<Tab> <Esc>:call my#GetSnippets("r","curry.R")<CR>

" Mappings:
nnoremap <buffer><silent> <F1>       :tabnew ~/.config/nvim/ftplugin/r.vim<CR>
nnoremap <buffer><silent> <F2>       :tabnew ~/.config/nvim/after/syntax/r.vim<CR>
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
inoremap <buffer><silent> {<CR>      <C-R>=getline(".")[col(".")-1]=="" ? "{\r}\e\<S-O>" : "{\r"<CR>
inoremap <buffer><silent> (<CR>      <C-R>=getline(".")[col(".")-1]=="" ? "(\r)\e\<S-O>" : "(\r"<CR>
nnoremap <buffer><silent> <leader>;  :call my#DelFuncCall('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>
nnoremap <buffer><silent> <leader>cc :RStop<CR>
