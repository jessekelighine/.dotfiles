" ~/.config/nvim/after/ftplugin/css.vim

" SNIPPETS:
inoremap <silent><buffer> :quarto<Tab> <Esc>:call snippets#Get("css", "quarto.css")<CR>
inoremap <silent><buffer> :style<Tab>  <Esc>:call snippets#Get("css", "style.css")<CR>
