" ~/.config/nvim/autoload/tex.vim

" Visual select a "section".
" type = { "a", "i" }.
function! tex#GetSection(type='a')
	let l:line = line('.')
	let l:list = [ 0 ] + <SID>GetSection() + [ line('$')+1 ]
	for l:i in range(len(l:list)-1)
		let [ l:begin, l:end ] = [ l:list[l:i], l:list[l:i+1]-1 ]
		if l:begin<=l:line && l:line<=l:end | break | endif
	endfor
	let l:begin = l:begin==0 ? 1 : l:begin + ( a:type=='a' ? 0 : 1 )
	if l:end-l:begin<0 | throw "Invlaid select range." | endif
	call cursor(l:begin, 0)
	exec { x -> "norm! V" . ( x==0 ? "" : x."j" ) }( l:end - l:begin )
endfunction
" Get line numbers of section headings.
function! <SID>GetSection()
	let l:patt = '\\\(sub\)*\(section\|paragraph\|chapter\)\|\\\(begin\|end\){document}'
	let l:pos  = getpos('.')
	let l:list = []
	exe "g/".l:patt."/let l:list = l:list + [ line('.') ]"
	cal setpos('.',l:pos)
	return l:list
endfunction

" Print the line number (sub)sections.
function! tex#FindSection() abort
	let l:count = 0
	let l:results = []
	let l:pos = getpos('.')
	echo '  Line  Index  Title'
	echo repeat('=',79)
	g/^\\\(sub\)*\(section\|paragraph\|chapter\)/
				\ let l:temp = getline(".") |
				\ let l:temp = substitute(l:temp, '\\subparagraph\*\{0,1}{\(.\{-}\)}.*','                    \1','') |
				\ let l:temp = substitute(l:temp,    '\\paragraph\*\{0,1}{\(.\{-}\)}.*','                \1','') |
				\ let l:temp = substitute(l:temp,'\\subsubsection\*\{0,1}{\(.\{-}\)}.*','            \1','') |
				\ let l:temp = substitute(l:temp,   '\\subsection\*\{0,1}{\(.\{-}\)}.*','        \1','') |
				\ let l:temp = substitute(l:temp,      '\\section\*\{0,1}{\(.\{-}\)}.*','    \1','') |
				\ let l:temp = substitute(l:temp,      '\\chapter\*\{0,1}{\(.\{-}\)}.*','\1','') |
				\ echo printf("%6s %6s  %s",line("."),l:count,l:temp) |
				\ call add(l:results,line(".")) |
				\ let l:count += 1
	let l:temp = input("--> Go to: ")
	if l:temp=~'\d\+' | exec "norm! ".l:results[l:temp]."G" | else | call setpos('.',l:pos) | endif
endfunction

" Delete parenthesis modifiers (left/right,big,large,...).
function! tex#DelLeftRight()
	if getline(".")[col(".")-1] =~ '['.'()'.'\[\]'.'{}'.']'
		silent norm hhvawohx%hhviwohx%
	else
		call search('\\\(left\|Big\|big\)','cb',line(".")) | exec 'norm de'
		call search('\\\(right\|Big\|big\)','',line("."))  | exec 'norm de'
	endif
endfunction

function! tex#ContiCompiTmux(start,engine='xelatex') abort
	packadd! vim-slime
	if a:start && vimslime#Target()==""
		let l:command = 'tmux split -c "$PWD";'
					\ . 'tmux resize-pane -U 12;'
					\ . "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';"
					\ . 'tmux last-pane;'
		let l:targets = system(l:command)->split('\n')->map('split(v:val," ")')
		for l:pane in l:targets | if l:pane[1]==1 | break | endif | endfor
		call vimslime#SetTarget(l:pane[0])
		let l:command = 'latexmk '
					\ . ( a:engine=='xelatex' ? '-pdfxe' : '-pdflatex' )
					\ . ' -pvc -view=none -halt-on-error ' . @%
		call vimslime#Send(l:command,1)
		augroup ContiCompiTmux
			autocmd!
			autocmd VimLeave * exe vimslime#Target()=="" ? "" : 'call vimslime#Send("\<C-C>exit",1)'
		augroup END
	elseif  a:start && vimslime#Target()!=""
		call system("tmux resize-pane -Z")
	elseif !a:start && vimslime#Target()!=""
		call vimslime#Send("\<C-C>exit",1)
		call vimslime#UnsetTarget()
	elseif !a:start && vimslime#Target()==""
		redraw | echom "--> No Tmux Pane to close."
	endif
endfunction

" Continuous Compilation.
" function! tex#ContiCompi(checkout=0,engine='xelatex') abort
" 	if a:checkout
" 		execut 'buffer '.b:tex_conticompi_bufnr
" 		return 0
" 	endif
" 	if !exists('b:tex_conticompi_bufnr')
" 		let l:orig = bufnr()
" 		silent exec 'norm! :term latexmk ' . ( a:engine=='xelatex' ? '-pdfxe' : '-pdflatex' ) . ' -pvc -view=none -halt-on-error '.@%."\<CR>"
" 		silent exec 'nnoremap <silent><buffer> <Space> :buffer '.l:orig."\<CR>"
" 		let l:term = bufnr()
" 		silent exec 'buffer '.l:orig
" 		let b:tex_conticompi_bufnr = l:term
" 		redraw | echo '--> Continuous Compilation: ON ('.a:engine.')'
" 	else
" 		silent execute ':bd! '.b:tex_conticompi_bufnr
" 		unlet b:tex_conticompi_bufnr
" 		redraw | echo '--> Continuous Compilation: OFF'
" 	endif
" 	return 0
" endfunction

" Compile LaTeX files.
function! tex#Compile(type='xelatex', call_type='jobstart')
	silent write
	" generate command
	if     a:type=="xelatex"      | let l:cmd = join(['xelatex',                @%], " ")
	elseif a:type=="latex"        | let l:cmd = join(['latex',                  @%], " ")
	elseif a:type=="cwtex"        | let l:cmd = join(['source ~/.zshrc; cwtex', @%], " ")
	elseif a:type=="xelatexmk"    | let l:cmd = join(['latexmk -pdfxe',         @%], " ")
	elseif a:type=="latexmk"      | let l:cmd = join(['latexmk -pdf',           @%], " ")
	elseif a:type=="xelatexmkpvc" | let l:cmd = join(['latexmk -pdfxe -pvc -view=none -halt-on-error', @%], " ")
	elseif a:type=="latexmkpvc"   | let l:cmd = join(['latexmk -pdf   -pvc -view=none -halt-on-error', @%], " ")
	elseif a:type=="make"         | let l:cmd = 'make'
	elseif a:type=="png"          | let l:cmd = 'xelatex '.@%.'; convert                                -density 600 '.expand("%:r").'.pdf '.expand("%:r").'.png'
	elseif a:type=="png_white"    | let l:cmd = 'xelatex '.@%.'; convert -background "#FFFFFF" -flatten -density 600 '.expand("%:r").'.pdf '.expand("%:r").'.png'
	elseif a:type==''             | echom "--> ERROR: wrong `type`." | return
	else                          | let l:cmd = a:type               | endif
	redraw | echom " ! ".l:cmd
	" call command
	if     a:call_type=='jobstart' | call jobstart(l:cmd)
	elseif a:call_type=='termopen' | call terminal#Open(l:cmd)
	elseif a:call_type=='!'        | exec '!'.l:cmd
	else | echom "--> ERROR: wrong `call_type`." | return | endif
endfunction

" insert empty environment.
function! tex#EmptyEnvironment(name="", append="")
	let l:environ = a:name!="" ? a:name : input('Environment name: ')
	if  l:environ == '' | return | endif
	exec 'norm A'.
				\ '\begin{'.l:environ.'}'.a:append."\<CR>".
				\ '\end{'.l:environ.'}'.
				\ "\<Esc>vk="
endfunction

" creates quote object in latex.
function! tex#Quotes(code, double) abort
	let [ l:begin , l:end ] = [ repeat("`",(a:double?2:1)) , repeat("'",(a:double?2:1)) ]
	call search(l:begin,"bcW") | exec "norm ".repeat('l',(a:double?2:1))
	if a:code=="i"                                 | call search(l:end, "sW") | exec "norm hv`'" | endif
	if a:code=="a" &&  a:double | exec "norm 2h"   | call search(l:end,"seW") | exec "norm v`'"  | endif
	if a:code=="q" &&  a:double | exec "norm hvhx" | call search(l:end,"seW") | exec "norm vh"   | endif
	if a:code=="a" && !a:double | exec "norm 1h"   | call search(l:end,"seW") | exec "norm v`'"  | endif
	if a:code=="q" && !a:double | exec "norm hvx"  | call search(l:end,"seW") | exec "norm v"    | endif
endfunction

" replace the environment name on that line.
function! <SID>EnvironmentReplace(change)
	call execute( 's/\V\\\(begin\|end\){\.\{-}}/\\\1{' . a:change . '}/' )
endfunction

" get the environment name. Helper function for tex#EnvironmentStar().
function! <SID>EnvironmentGet()
	return matchstr(getline('.'),'^\s*\\\(begin\|end\){\zs.\{-}\ze}')
endfunction

" change a tex environment.
function! tex#EnvironmentChange(to='')
	let l:to = a:to=='' ? input('Environment Name: ') : a:to
	if  l:to=='' | return | endif
	let l:pos = getpos('.') | exec 'norm _%'
	call <SID>EnvironmentReplace(l:to) | call setpos('.',l:pos)
	call <SID>EnvironmentReplace(l:to)
endfunction

" toggle star of a tex environment.
function! tex#EnvironmentStar()
	let l:en = <SID>EnvironmentGet()
	let l:to = strpart(l:en,strlen(l:en)-1)=='*' ? strpart(l:en,0,strlen(l:en)-1) : l:en.'*'
	call tex#EnvironmentChange(l:to)
endfunction

" delete the environment surrounding.
function! tex#EnvironmentDelete()
	let l:pos1 = getpos('.') | norm _%
	let l:pos2 = getpos('.')
	let l:pos  = l:pos1
	if l:pos1[1]>l:pos2[1] | let [l:pos1,l:pos2] = [l:pos2,l:pos1] | endif
	call setpos('.',l:pos2) | delete
	call setpos('.',l:pos1) | delete
	let l:pos2[1] = l:pos2[1] - 2
	exec "norm \<S-V>".( l:pos2[1] - l:pos1[1] ).'j='
	call setpos('.',l:pos)
endfunction
