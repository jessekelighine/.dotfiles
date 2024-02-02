" ~/.config/nvim/autoload/sh.vim

" expand curly braces
function! sh#CurlyExpand()
	let l:tmp = { x -> x[col("."):(len(x)-1)] }( getline(".") )
	let l:tmp = empty(l:tmp) || l:tmp ==# ' \+'
	if  l:tmp | call feedkeys("a{}\<Esc>i\<CR>\<Esc>\<S-O>")
	else      | call feedkeys(( col(".")==1 ? "i" : "a" ) . "{\<Esc>a\<CR>")
	endif
endfunction
