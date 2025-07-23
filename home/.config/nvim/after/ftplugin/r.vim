" ~/.config/nvim/after/ftplugin/r.vim
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r

" SETTINGS:
setlocal winminwidth=1
setlocal smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
let b:match_words  = '\<tic\>:\<toc\>'
let b:surround_116 = "tic()\rtoc()"
let b:surround_84  = "timer$tic()\rtimer$toc()"
let b:surround_112 = "pdf(file = \"\")\rdev.off()"
command! -buffer -nargs=0 FindSection call r#FindSection()
command! -buffer -nargs=0 -range FormatR :'<,'>RFormat

" R PIPE:
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
command! -buffer -nargs=0 PipeSwitch let b:r_pipe = b:r_pipe == '%>%' ? '|>' : '%>%' | echom ' Pipe: ' .. b:r_pipe
command! -buffer -nargs=0 PipeAutoDetect call r#PipeAutoDetect() | echom ' Pipe: ' .. b:r_pipe
silent! PipeAutoDetect

" LASTMOD:
let b:lastmod_pattern = '^\(' .. "#' @note Date Created: " .. '\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)
command! -buffer -nargs=? AutoLastMod call r#AutoLastMod(<q-args>)
silent! AutoLastMod off

" SNIPPETS:
inoremap <buffer> :sign<Tab>     <Esc>:call snippets#Get("r","sign.R")<CR>
inoremap <buffer> :future<Tab>   <Esc>:call snippets#Get("r","future.R")<CR>
inoremap <buffer> :qui<Tab>      <Esc>:call snippets#Get("r","skeleton.R")<CR>:LastMod<CR>
inoremap <buffer> :lib<Tab>      <Esc>:call snippets#Get("r","library.R")<CR>
inoremap <buffer> :ggs<Tab>      <Esc>:call snippets#Get("r","ggsave.R")<CR>
inoremap <buffer> :ggch<Tab>     <Esc>:call snippets#Get("r","ggplotChinese.R")<CR>
inoremap <buffer> :se<Tab>       <Esc>:call snippets#Get("r","robust.R")<CR>
inoremap <buffer> :log<Tab>      <Esc>:call snippets#Get("r","logfile.R")<CR>
inoremap <buffer> :cl<Tab>       <Esc>:call snippets#Get("r","consolelog.R")<CR>
inoremap <buffer> :mode<Tab>     <Esc>:call snippets#Get("r","modus.R")<CR>
inoremap <buffer> :rm<Tab>       <Esc>:call snippets#Get("r","rm.R")<CR>
inoremap <buffer> :timer<Tab>    <Esc>:call snippets#Get("r","timer.R")<CR>
inoremap <buffer> :curry<Tab>    <Esc>:call snippets#Get("r","curry.R")<CR>
inoremap <buffer> :showtext<Tab> <Esc>:call snippets#Get("r","showtext.R")<CR>
inoremap <buffer> :dt<Tab>       <Esc>:call snippets#Get("r","datatable.R")<CR>
inoremap <buffer> :bl<Tab>       <Esc>:call snippets#Get("r","block.R")<CR>

" R MACROS:
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>
nnoremap <buffer><silent> <leader>cc :RStop<CR>
