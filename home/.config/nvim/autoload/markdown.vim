" ~/.config/nvim/autoload/markdown.vim

" fill-in Author
function! markdown#FillAuthor(author=snippet#GetAuthor())
	let l:position = getpos(".")
	let l:command = "1," .. min([line('$'), 5])
				\ .. 'g?^author?'
				\ .. 's?:\(\s\{0,}\)\S\+?:\1"' .. a:author .. '"?'
	silent! execute l:command
	nohlsearch | redraw | echo ""
	call setpos(".", l:position)
endfunction

" open markdown in browser
function! markdown#View(force_open_file=0)
	let l:browser = "firefox"
	let l:command = "open -a " .. l:browser
	if a:force_open_file || !exists("b:markdown_view")
		let l:html_file = expand("%:p:r") .. ".html"
		let l:view_file = file_readable(l:html_file) ? l:html_file : expand("%:p")
		let l:command = l:command .. " file://" .. l:view_file
		let b:markdown_view = 1
	endif
	call system(l:command)
endfunction

" toggle codeblock syntax.
function! markdown#ClearCodeSyntax()
	if !exists("b:markdown_code_syntax_toggle")
		let b:markdown_code_syntax_toggle = 0
	endif
	if b:markdown_code_syntax_toggle
		let b:markdown_code_syntax_toggle = 0
		silent syntax enable MarkdownCodeblock
		redraw | echom "Markdown CodeBlock: ENABLED"
	else
		let b:markdown_code_syntax_toggle = 1
		silent syntax clear MarkdownCodeblock
		echom "Markdown CodeBlock: CLEARED"
	endif
endfunction

" Index sections
function! markdown#FindSection(index="") abort
	" Populate Section Lines and Titles
	let l:pos = getpos('.')
	let l:index = 0
	let l:section_lines = []
	let l:section_titles = []
	global/^#\+/
				\ let l:temp = getline(".") |
				\ let l:temp = substitute(l:temp, repeat("#",5) .. '\s\+\(.*\)', repeat(' ',16) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",4) .. '\s\+\(.*\)', repeat(' ',12) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",3) .. '\s\+\(.*\)', repeat(' ', 8) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",2) .. '\s\+\(.*\)', repeat(' ', 4) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",1) .. '\s\+\(.*\)', repeat(' ', 0) .. '\1', '') |
				\ call add(l:section_lines, line(".")) |
				\ call add(l:section_titles, l:temp) |
				\ let l:index += 1

	" Prompt for Index if Not Provided
	let l:index = a:index 
	if l:index == ""
		let l:header_format = "%6s %6s  %s"
		let l:header = printf(l:header_format, "Line", "Index", "1   2   3   4   5")
		echo l:header .. "\n" .. repeat("=", len(l:header))
		for l:index in range(len(l:section_lines))
			let l:line = l:section_lines[l:index]
			let l:title = l:section_titles[l:index]
			echo printf(l:header_format, l:line, l:index, l:title)
		endfor
		let l:index = input("--> Go to: ")
	endif

	" Jump to the Selected Section
	if l:index =~ '\d\+'
		execute "norm! " .. l:section_lines[l:index] .. "G0"
	else
		call setpos('.',l:pos)
	endif
endfunction
