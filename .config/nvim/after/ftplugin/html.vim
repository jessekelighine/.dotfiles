" ~/.config/nvim/after/ftplugin/html.vim
" ~/.config/nvim/after/ftplugin/html_snippets/

if &ft == "markdown" | finish | endif
setlocal shiftwidth=2 softtabstop=2 tabstop=2 smarttab

" UTILITIES
nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/after/ftplugin/html.vim<CR>
nnoremap <buffer> <leader>p :! open <C-R>'%:r.html<CR><CR>

" SNIPPETS
inoremap <buffer> :qui<Tab> <esc>:call my#GetSnippets('html','html_qui.html')<CR>
