" ~/.config/nvim/ftplugin/rmd.vim
" ~/.config/nvim/autoload/rmd.vim

if ( &ft == "markdown" ) | finish | endif

let g:R_rmdchunk = 0

source ~/.config/nvim/ftplugin/r.vim
source ~/.config/nvim/ftplugin/markdown.vim

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/rmd.vim<CR>
nnoremap <buffer> <F5> :call rmd#Knit()<CR>

imap <buffer> :cr<Tab> <C-G>u```{r}<Enter>```<esc><S-O>
imap <buffer> :crs<Tab> <C-G>u```{r,message=FALSE,warning=FALSE}<Enter>```<esc><S-O>
