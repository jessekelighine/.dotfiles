" ~/.config/nvim/autoload/markdown.vim

" compile markdown to HTML on save
function! markdown#PandocPVC(type="")
	if !exists("b:markdown_pandoc_pvc_type") || a:type!=""
		let b:markdown_pandoc_pvc_type = a:type=="" ? "plain" : a:type
		call markdown#ToHtml(b:markdown_pandoc_pvc_type)
		augroup PandocPVC
			autocmd!
			autocmd! BufWritePost *.md :call markdown#ToHtml(b:markdown_pandoc_pvc_type)
		augroup END
		echo "--> PandocPVC: ON (".b:markdown_pandoc_pvc_type.")"
	else
		unlet b:markdown_pandoc_pvc_type
		autocmd! PandocPVC
		echo "--> PandocPVC: OFF"
	endif
endfunction

" convert from markdown to html.
function! markdown#ToHtml(type)
	let l:css = "~/.config/nvim/snippets/markdown/style.css"
	let l:cjk = "markdown+east_asian_line_breaks"
	let l:to  = "-o ".expand("%:r").".html"
	silent write
	if     a:type == "plain"    | call system("pandoc -f ".l:cjk." -s                         --mathjax -c ".l:css." ".expand("%")." ".l:to)
	elseif a:type == "nonumber" | call system("pandoc -f ".l:cjk." -s --toc                   --mathjax -c ".l:css." ".expand("%")." ".l:to)
	elseif a:type == "number"   | call system("pandoc -f ".l:cjk." -s --toc --number-sections --mathjax -c ".l:css." ".expand("%")." ".l:to)
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
