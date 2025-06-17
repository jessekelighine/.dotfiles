" ~/.config/nvim/autoload/r.vim

" Toggle/Set augroup MarkdownAutoLastMod
function! r#AutoLastMod(set="", toggle=0)
	let l:status = exists("#RAutoLastMod#BufWrite")
	let l:switch_on =
				\ a:set =~? "on" ? 1 :
				\ a:set =~? "off" ? 0 :
				\ a:toggle ? !l:status : l:status
	augroup RAutoLastMod
		autocmd!
		silent execute l:switch_on ? "autocmd BufWrite *.R,*.r silent! undojoin | LastMod" : ""
	augroup END
	echo " AutoLastMod is now " .. ( l:switch_on ? "ON" : "OFF" )
endfunction

" Print the line number (sub)sections.
function! r#FindSection() abort
	let l:index = 0
	let l:section_lines = []
	let l:pos = getpos('.')
	let l:header_format = "%6s %6s  %s"
	let l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^#\{2,} /
				\ let l:display_name = substitute(getline("."), '\(^#\{2,} \| #\+$\)', "", "g") |
				\ echo printf(l:header_format, line("."), l:index, l:display_name) |
				\ call add(l:section_lines, line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	exe l:index =~ '\d\+' ? "norm! " .. l:section_lines[l:index] .. "G" : "call setpos('.',l:pos)"
endfunction

" " explain "dcast" and "melt" from data.table
" function! r#DatatableExplain(name)
" 	exec "split $HOME/.config/nvim/snippets/r/datatable-" .. a:name .. ".md"
" endfunction
" function! r#DatatableExplainComplete(ArgLead, CmdLine, CursorPos)
" 	return "dcast"."\n"."melt"
" endfunction

""" Pipe Symbol """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" expand pipe symbol
function! r#PipeExpand(type)
	execute "norm! a" .. ( getline(".")[col(".") - 1] != " " ? " " : "" ) .. b:r_pipe
	if     a:type == "CR"  | call feedkeys("a\<CR>")
	elseif a:type == "Tab" | call feedkeys("a" .. ( getline(".")[col(".")]==" " ? "" : " " ))
	endif
endfunction

" guess the pipe symbol
function! r#PipeAutoDetect() abort
	let l:recognized_packages = [ 'tidyverse', 'magrittr' ]
	let l:package_pattern = join(l:recognized_packages, '\|')
	let b:r_pipe = search(l:package_pattern, 'nw') > 0 ? "%>%" : "|>"
endfunction
