" ~/.vim/after/ftplugin/tex/beamer.vim

" BEAMER: insert frame.
inoremap <buffer> \fr<Tab> <Esc>:call tex#EmptyEnvironment('frame','{}')<CR>$
inoremap <buffer> \bl<Tab> <Esc>:call tex#EmptyEnvironment('block','{}')<CR>$
