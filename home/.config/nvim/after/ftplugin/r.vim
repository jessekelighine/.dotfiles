" ~/.config/nvim/after/ftplugin/r.vim
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r

" Nvim-R
" let R_assign = 0
" let R_disable_cmds = [ "RSendLine" ]

" Settings:
setlocal winminwidth=1
setlocal smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
let b:match_words  = '\<tic\>:\<toc\>'
let b:surround_116 = "tic()\rtoc()"
let b:surround_84  = "timer$tic()\rtimer$toc()"
let b:surround_112 = "pdf(file = \"\")\rdev.off()"
let b:r_pipe_type  = "|>"
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(#* *Last Modified: \)[^ ]*\(.*\)', min([line('$'),10]))
command! -buffer -nargs=0 PipeSwitch :let b:r_pipe_type = b:r_pipe_type=='%>%' ? '|>' : '%>%' | echom ' Pipe: ' .. b:r_pipe_type
command! -buffer -nargs=0 FindSection :call r#FindSection()
command! -buffer -nargs=0 -range FormatR :'<,'>RFormat
command! -buffer -nargs=? -bang AutoLastMod :call r#AutoLastMod(<q-args>,<bang>0)
silent AutoLastMod on
" command! -buffer -nargs=1 -complete=custom,r#DatatableExplainComplete DatatableExplain :call r#DatatableExplain(<q-args>)

" Snippets:
inoremap <buffer> :sign<Tab>  <Esc>:call my#GetSnippets("r","sign.R")<CR>
inoremap <buffer> :bl<Tab>    <Esc>:call my#GetSnippets("r","block.R")<CR>
inoremap <buffer> :qui<Tab>   <Esc>:call my#GetSnippets("r","qui.R")<CR>
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
nnoremap <buffer><silent> <F1>       :tabnew ~/.config/nvim/after/ftplugin/r.vim<CR>
nnoremap <buffer><silent> <F2>       :tabnew ~/.config/nvim/after/syntax/r.vim<CR>
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>
nnoremap <buffer><silent> <leader>cc :RStop<CR>
