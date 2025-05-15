" ~/.config/nvim/autoload/markdown.vim

" Toggle/Set augroup MarkdownAutoLastMod
function! markdown#AutoLastMod(set="", toggle=1) abort
	let l:status = exists("#MarkdownAutoLastMod#BufWrite")
	let l:switch_on =
				\ a:set =~? "on"  ? 1 :
				\ a:set =~? "off" ? 0 :
				\ a:toggle ? !l:status : l:status
	augroup MarkdownAutoLastMod
		autocmd!
		silent execute l:switch_on ? "autocmd BufWrite *.qmd,*.md,*.markdown,*.Rmd,*.rmd silent! undojoin | LastMod" : ""
	augroup END
	echom " AutoLastMod is now " .. ( l:switch_on ? "ON" : "OFF" )
endfunction

" fill-in Author
function! markdown#FillAuthor(author=my#GetAuthor())
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
