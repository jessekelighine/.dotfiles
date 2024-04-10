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
let g:markdown_view = 0
if !exists("b:markdown_view_file") | let b:markdown_view_file = expand("%:p") | endif
function! markdown#View(start=!g:markdown_view)
	if !a:start | call system('open -a firefox') | return | endif
	call system("open -a firefox file://" .. b:markdown_view_file)
	let g:markdown_view = 1
endfunction

" toggle codeblock syntax.
function! markdown#ClearCodeSyntax()
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
