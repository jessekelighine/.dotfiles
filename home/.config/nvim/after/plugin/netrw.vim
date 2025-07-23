" ~/.config/nvim/after/plugin/netrw.vim

let g:netrw_banner=0
let g:netrw_fastbrowse=0
let g:netrw_liststyle=3
let g:netrw_altv=1

augroup Netrw
	autocmd!
	autocmd FileType netrw setlocal bufhidden=delete
augroup END
