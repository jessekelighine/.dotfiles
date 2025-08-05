" ~/.config/nvim/after/ftplugin/html.vim

if &filetype == "markdown"
	finish
endif
setlocal shiftwidth=2 softtabstop=2 tabstop=2 smarttab

" UTILITIES:
nnoremap <buffer> <leader>p :! open <C-R>'%:r.html<CR><CR>

" SNIPPET:
inoremap <buffer> :qui<Tab> <esc>:call snippet#Get('html','html_qui.html')<CR>
