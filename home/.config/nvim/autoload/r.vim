" ~/.config/nvim/autoload/r.vim

" Toggle/Set augroup MarkdownAutoLastMod
function! <SID>LastMod() abort
	try
		undojoin | LastMod
	catch
		LastMod
	endtry
endfunction
function! r#AutoLastMod(set = "")
	let l:status = exists("#RAutoLastMod#BufWritePost")
	let l:switch_on = a:set =~? "on" ? 1 : ( a:set =~? "off" ? 0 : !l:status )
	augroup RAutoLastMod
		autocmd!
		if l:switch_on
			autocmd BufWritePost *.R,*.r call <SID>LastMod()
		endif
	augroup END
	echo " AutoLastMod is now " .. ( l:switch_on ? "ON" : "OFF" )
endfunction

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
	execute "norm! a" .. ( getline(".")[col(".") - 1] != " " ? " " : "" ) .. b:r_pipe
	if     a:type =~ "CR"  | call feedkeys("a\<CR>")
	elseif a:type =~ "Tab" | call feedkeys("a" .. ( getline(".")[col(".")]==" " ? "" : " " ))
	endif
endfunction

" guess the pipe symbol
function! r#PipeAutoDetect() abort
	let l:recognized_packages = [ 'tidyverse', 'magrittr' ]
	let l:package_pattern = join(l:recognized_packages, '\|')
	let b:r_pipe = search(l:package_pattern, 'nw') > 0 ? "%>%" : "|>"
endfunction
