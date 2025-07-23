" ~/.config/nvim/after/plugin/makeroom.vim

" put a:lines blank lines above/below the current line.
function! <SID>MakeRoom(direction, lines = 1) abort
	let l:command = join([
				\ "norm!",
				\ a:direction == "above" ? "O" : "o",
				\ repeat("\<CR>", a:lines - 1),
				\ "\<Esc>"
				\ ])
	let l:line = line(".") + ( a:direction == "above" ? a:lines : 0 )
	let l:col  = col(".")
	silent execute l:command
	call cursor(l:line, l:col)
endfunction

" nnoremap [<Space> <Cmd>call <SID>MakeRoom('above', v:count1)<CR>
" nnoremap ]<Space> <Cmd>call <SID>MakeRoom('below', v:count1)<CR>
