" ~/.config/nvim/after/ftplugin/sh.vim
" ~/.config/nvim/snippets/sh/
" ~/.config/nvim/autoload/sh.vim

setlocal signcolumn=yes:1
setlocal shiftwidth=4 softtabstop=4 tabstop=4 smarttab

" LASTMOD:
let b:lastmod_pattern = '^\(#* *Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

" SNIPPETS:
inoremap <buffer> :qui<Tab>  <Esc>:call snippets#Get('sh','shebang-env.sh')<CR>
inoremap <buffer> :sign<Tab> <Esc>:call snippets#Get('sh','sign.sh')<CR>
inoremap <buffer> :bl<Tab>   <Esc>:call snippets#Get('sh','block.sh')<CR>
