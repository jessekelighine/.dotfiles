" ~/.config/nvim/autoload/rmd.vim

function! rmd#Knit()
	! Rscript -e "rmarkdown::render('%:r.Rmd')"
endfunction
