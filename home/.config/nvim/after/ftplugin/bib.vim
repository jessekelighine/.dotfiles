" ~/.config/nvim/after/ftplugin/bib.vim
" ~/.config/nvim/snippets/bib/

command! -buffer -range FormatEntries :'<,'>!biber-format-pipe

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/bib.vim<CR>

inoremap <buffer> @a<Tab> <Esc>:call snippets#Get('bib','article.bib')<CR>$i
inoremap <buffer> @b<Tab> <Esc>:call snippets#Get('bib','book.bib')<CR>$i
inoremap <buffer> @i<Tab> <Esc>:call snippets#Get('bib','inbook.bib')<CR>$i
inoremap <buffer> @m<Tab> <Esc>:call snippets#Get('bib','misc.bib')<CR>$i
inoremap <buffer> @o<Tab> <Esc>:call snippets#Get('bib','online.bib')<CR>$i
inoremap <buffer> @p<Tab> <Esc>:call snippets#Get('bib','proceedings.bib')<CR>$i
inoremap <buffer> @t<Tab> <Esc>:call snippets#Get('bib','thesis.bib')<CR>$i
