" ~/.config/nvim/autoload/r.vim

" Print the line number (sub)sections.
function! r#FindSection() abort
	let l:index = 0
	let l:section_lines = []
	let l:position = getpos('.')
	let l:header_format = "%6s %6s  %s"
	let l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^#\{2,} /
				\ let l:display_name = substitute(getline("."), '\(^#\{2,} \| #\+$\)', "", "g") |
				\ echo printf(l:header_format, line("."), l:index, l:display_name) |
				\ call add(l:section_lines, line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	let l:valid_index = l:index =~ '\d\+'
	if l:valid_index
		exec "norm! " .. l:section_lines[l:index] .. "G"
	else
		call setpos('.', l:position)
	endif
endfunction

" expand pipe symbol
function! r#PipeExpand(type)
	let l:curr_char = getline(".")[col(".") - 1]
	let l:next_char = getline(".")[col(".")]
	let l:space_before_pipe = l:curr_char == " " ? "" : " "
	let l:space_after_pipe  = l:next_char == " " ? "" : " "
	let l:keys = a:type == "cr" ? "a\<CR>" : ( "a" .. l:space_after_pipe )
	exec "norm! a" .. l:space_before_pipe .. b:r_pipe
	call feedkeys(l:keys)
endfunction

" guess the pipe symbol
function! r#PipeAutoDetect() abort
	" let l:recognized_packages = [ 'tidyverse', 'magrittr' ]
	let l:recognized_packages = ['NOPIPES']
	let l:package_pattern = join(l:recognized_packages, '\|')
	let b:r_pipe = search(l:package_pattern, 'nw') > 0 ? "%>%" : "|>"
endfunction
