" ~/.config/nvim/autoload/markdown.vim

function! markdown#FillAuthor(author=my#GetSnippetsAuthor())
	let l:pos = getpos(".")
	execute "1," .. min([line('$'),5]) .. 'g/^author/' .. 's/:\(\s\+\)\S\+/:\1"' .. a:author .. '"/'
	nohlsearch | redraw | echo ''
	call setpos(".", l:pos)
endfunction

" open markdown in firefox
let g:markdown_view = 0
function! markdown#View(start=!g:markdown_view)
	if !a:start | call system('open -a firefox') | return | endif
	let g:markdown_view = 1
	call system("firefox --new-window ".."file://"..expand("%:p"))
endfunction

" compile markdown to HTML on save
function! markdown#PandocPVC(type="")
	if !exists("b:markdown_pandoc_pvc_type") || a:type != ""
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

" Index sections
function! markdown#FindSection() abort
	let  [ l:index, l:section_lines, l:pos ] = [ 0, [], getpos('.') ]
	let  l:header_format = "%6s %6s  %s"
	let  l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^#\+/
				\ let l:temp = getline(".") |
				\ let l:temp = substitute(l:temp, repeat("#",5)..'\s\+\(.*\)', repeat(' ',16)..'\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",4)..'\s\+\(.*\)', repeat(' ',12)..'\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",3)..'\s\+\(.*\)', repeat(' ', 8)..'\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",2)..'\s\+\(.*\)', repeat(' ', 4)..'\1', '') |
				\ let l:temp = substitute(l:temp, repeat("#",1)..'\s\+\(.*\)', repeat(' ', 0)..'\1', '') |
				\ echo printf(l:header_format, line("."), l:index, l:temp) |
				\ call add(l:section_lines, line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	exe l:index =~ '^\d\+$' ? "norm! " .. l:section_lines[l:index] .. "G" : "call setpos('.',l:pos)"
endfunction
