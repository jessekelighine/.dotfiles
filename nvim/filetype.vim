" ~/.config/nvim/filetype.vim

augroup filetypedetect
	autocmd! BufRead,BufNewFile *.ctx,*.tex,*.tikz  setlocal filetype=tex
	autocmd! BufRead,BufNewFile *.csv,*.tsv         setlocal filetype=csv
	autocmd! BufRead,BufNewFile *.bc                setlocal filetype=bc
	autocmd! BufRead,BufNewFile *.pdfmarks,pdfmarks setlocal filetype=postscr
	autocmd! BufRead,BufNewFile *.make              setlocal filetype=make
augroup END
