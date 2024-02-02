" ~/.vim/after/ftplugin/tex/acronym.vim

" ACRONYM:
inoremap <buffer> \as<Tab> <C-G>u\acrshort{}<Left>
inoremap <buffer> \al<Tab> <C-G>u\acrlong{}<Left>
