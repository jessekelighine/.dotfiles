" ~/.config/nvim/after/ftplugin/bib.vim
" ~/.config/nvim/snippets/bib/

command! -buffer -range FormatEntries :'<,'>!biber-format-pipe

setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/bib.vim<CR>

inoremap <buffer> @a<Tab> <Esc>:call my#GetSnippets('bib','article.bib')<CR>$i
inoremap <buffer> @b<Tab> <Esc>:call my#GetSnippets('bib','book.bib')<CR>$i
inoremap <buffer> @i<Tab> <Esc>:call my#GetSnippets('bib','inbook.bib')<CR>$i
inoremap <buffer> @m<Tab> <Esc>:call my#GetSnippets('bib','misc.bib')<CR>$i
inoremap <buffer> @o<Tab> <Esc>:call my#GetSnippets('bib','online.bib')<CR>$i
inoremap <buffer> @p<Tab> <Esc>:call my#GetSnippets('bib','proceedings.bib')<CR>$i
inoremap <buffer> @t<Tab> <Esc>:call my#GetSnippets('bib','thesis.bib')<CR>$i
