" ~/.config/nvim/ftplugin/rmd.vim
" ~/.config/nvim/autoload/rmd.vim

let  &filetype =  "markdown"
if ( &filetype == "markdown" ) | finish | endif

" let g:R_rmdchunk = 0

" source ~/.config/nvim/ftplugin/r.vim
" source ~/.config/nvim/ftplugin/markdown.vim

" nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/rmd.vim<CR>
" nnoremap <buffer> <F5> :call rmd#Knit()<CR>

" inoremap <buffer> :cr<Tab> <C-G>u```{r}<Enter>```<esc><S-O>
" inoremap <buffer> :crs<Tab> <C-G>u```{r,message=FALSE,warning=FALSE}<Enter>```<esc><S-O>
