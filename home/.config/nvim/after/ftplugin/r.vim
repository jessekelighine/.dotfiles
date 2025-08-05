" ~/.config/nvim/after/ftplugin/r.vim
" ~/.config/nvim/after/ftplugin/r.lua
" ~/.config/nvim/lua/cmp/r.lua
" ~/.config/nvim/after/syntax/r.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/r/

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

" R MACROS:
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
nnoremap <buffer><silent> <leader>cc :RStop<CR>
