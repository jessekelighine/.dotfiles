" ~/.config/nvim/autoload/postscr.vim

" convert eps to pdf.
function! postscr#Convert()
	silent write
	! ps2pdf -dNOSAFER -dEPSCrop % %:r.pdf
endfunction
