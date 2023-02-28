" ~/.config/nvim/autoload/markdown.vim

" convert from markdown to html.
" Types: nonumber, number, plain, test, local.
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

" search for HTML comments.
function! markdown#CommentSearchHTML()
	/<!--\s\{-}\(\(.\|\n\)\{-}\)\s{-}-->
endfunction

" search for texts/questions of the form "(*...*)".
function! markdown#QuestionSearchHTML()
	/(\*\(\(.\|\n\)\{-}\)\*)
endfunction

" let HTML comments be visible in html.
function! markdown#ToggleHtmlComments()
	try
		exe '%s/<!--\s\+\(\(.\|\n\)\{-}\)\s\+-->/[*\1*]/g'
		let l:status = ''
	catch
		exe '%s/\[\*\(\(.\|\n\)\{-}\)\*\]/<!-- \1 -->/g'
		let l:status = '[IN]'
	endtry
	echom "--> HTML comments to '".l:status."visible'!"
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
	let l:temp = input("--> Go to: ")
	if l:temp=~'\d\+' | exec "norm! ".l:results[l:temp]."G" | else | call setpos('.',l:pos) | endif
endfunction
