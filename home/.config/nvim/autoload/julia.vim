" ~/.config/nvim/autoload/julia.vim

" expand pipe symbol
function! julia#PipeExpand(type)
	let l:julia_pipe = '|>'
	let l:curr_char = getline(".")[col(".") - 1]
	let l:next_char = getline(".")[col(".")]
	let l:space_before_pipe = l:curr_char == " " ? "" : " "
	let l:space_after_pipe  = l:next_char == " " ? "" : " "
	let l:keys = a:type == "cr" ? "a\<CR>" : ( "a" .. l:space_after_pipe )
	exec "norm! a" .. l:space_before_pipe .. l:julia_pipe
	call feedkeys(l:keys)
endfunction
