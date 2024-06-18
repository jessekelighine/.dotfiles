" ~/.config/nvim/autoload/markdown.vim

function! markdown#FillAuthor(author=my#GetAuthor())
	let l:position = getpos(".")
	execute "1," .. min([line('$'),5])
				\ .. 'g/^author/'
				\ .. 's/:\(\s\+\)\S\+/:\1"' .. a:author .. '"/'
	nohlsearch | redraw | echo ""
	call setpos(".", l:position)
endfunction

" open markdown in firefox
function! markdown#View(force_view=0)
	let l:browser = "firefox"
	let l:command = "open -a " .. l:browser
	if !exists("b:markdown_view_file")
		let b:markdown_view_file = file_readable(expand("%:p:r") .. ".html")
					\ ? expand("%:p:r") .. ".html"
					\ : expand("%:p")
	endif
	if a:force_view || !exists("g:markdown_view")
		call system(l:command .. " file://" .. b:markdown_view_file)
		let g:markdown_view = 1
	else
		call system(l:command)
		return
	endif
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
function! markdown#FindSection() abort
	let l:pos = getpos('.')
	let l:index = 0
	let l:section_lines = []
	let l:header_format = "%6s %6s  %s"
	let l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^#\+/
				\ let l:temp = getline(".") |
				\ let l:temp = substitute(l:temp, repeat("#",5) .. '\s\+\(.*\)', repeat(' ',16) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",4) .. '\s\+\(.*\)', repeat(' ',12) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",3) .. '\s\+\(.*\)', repeat(' ', 8) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",2) .. '\s\+\(.*\)', repeat(' ', 4) .. '\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",1) .. '\s\+\(.*\)', repeat(' ', 0) .. '\1', '') |
				\ echo printf(l:header_format, line("."), l:index, l:temp) |
				\ call add(l:section_lines, line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	exe l:index =~ '^\d\+$' ? "norm! " .. l:section_lines[l:index] .. "G" : "call setpos('.',l:pos)"
endfunction
