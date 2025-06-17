" ~/.config/nvim/after/ftplugin/css.vim

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/css.vim<CR>

" SNIPPETS:
inoremap <silent><buffer> :quarto<Tab> <Esc>:call snippets#Get("css", "quarto.css")<CR>
