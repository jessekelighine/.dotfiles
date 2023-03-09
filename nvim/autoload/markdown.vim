" ~/.config/nvim/autoload/markdown.vim

" convert from markdown to html.
function! markdown#ToHtml(type)
	silent write
	if     a:type == "plain"    | ! pandoc -f markdown+east_asian_line_breaks -s                                   -c ~/.config/nvim/snippets/markdown/notion.css % -o %:r.html
	elseif a:type == "nonumber" | ! pandoc -f markdown+east_asian_line_breaks -s --toc                   --mathjax -c ~/.config/nvim/snippets/markdown/notion.css % -o %:r.html
	elseif a:type == "number"   | ! pandoc -f markdown+east_asian_line_breaks -s --toc --number-sections --mathjax -c ~/.config/nvim/snippets/markdown/notion.css % -o %:r.html
	elseif a:type == "test"     | ! pandoc -f markdown+east_asian_line_breaks -s --toc --number-sections --mathjax -c ~/Desktop/test.css                          % -o %:r.html
	elseif a:type == "local"    | ! pandoc -f markdown+east_asian_line_breaks -s --toc --number-sections --mathjax -c ./notion.css                                % -o %:r.html
	else | echom "ERROR: wrong compiler code" | endif
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

" Print the line number (sub)sections.
function! markdown#FindSection() abort
	let l:count = 0
	let l:results = []
	let l:pos = getpos('.')
	echo '  Line  Index  Title'
	echo repeat('=',79)
	g/^#\+/
				\ let l:temp = getline(".") |
				\ let l:temp = substitute(l:temp,'#####\(.*\)','                \1','') |
				\ let l:temp = substitute(l:temp, '####\(.*\)','            \1','') |
				\ let l:temp = substitute(l:temp,  '###\(.*\)','        \1','') |
				\ let l:temp = substitute(l:temp,   '##\(.*\)','    \1','') |
				\ let l:temp = substitute(l:temp,    '#\(.*\)','\1','') |
				\ echo printf("%6s %6s  %s",line("."),l:count,l:temp) |
				\ call add(l:results,line(".")) |
				\ let l:count += 1
	let l:rspn = input("--> Go to: ")
	if l:rspn=~'^\d\+$' | exec "norm! ".l:results[l:rspn]."G"
	else | call setpos('.',l:pos)
	endif
endfunction
