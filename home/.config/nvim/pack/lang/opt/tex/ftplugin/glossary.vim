" ~/.vim/after/ftplugin/tex/acronym.vim

" ACRONYM:
inoremap <buffer> \as<Tab> <C-G>u\acrshort{}<Left>
inoremap <buffer> \al<Tab> <C-G>u\acrlong{}<Left>
inoremap <buffer> \g<Tab>  <C-G>u\gls*{}<Left>
inoremap <buffer> \gl<Tab>  <C-G>u\glsentrylong{}<Left>
inoremap <buffer> \gs<Tab>  <C-G>u\glsentryshort{}<Left>
