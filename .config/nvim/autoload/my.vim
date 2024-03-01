" my.vim

""" Snippets """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" read from snippets.
function! my#GetSnippets(type, name, indent=1, delete_begin=1, cursor_begin=1)
	let [ l:begin, l:lines ] = [ line("."), line("$") ]
	execute "read " .. $HOME .. "/.config/nvim/snippets/" .. a:type .. "/" .. a:name
	let l:end = l:begin + ( line("$") - l:lines ) - 1
	call cursor(l:begin,0)
	if a:delete_begin | exec "norm! dd"                           | endif
	if a:indent       | exec l:begin .. "," .. l:end .. "norm v=" | endif
	if a:cursor_begin | call cursor(l:begin,0)                    | endif
endfunction

function! my#GetAuthor()
 	let l:path = $HOME .. "/.config/nvim/snippets/website"
	return readfile(l:path)[0]
endfunction

""" Miscellaneous """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" source a local vimrc file if exists.
function! my#LocalVimrc(filename=".vimrc")
	if filereadable(a:filename)
		call execute("source " .. a:filename)
	endif
endfunction

" remove trailing white spaces.
function! my#RemoveTrailingSpaces(line1=1,line2=line('$'))
	let l:pos = getpos(".")
	try
		silent execute join([a:line1,a:line2],',') . 's/^\(.\{-}\)\s\+$/\1/g'
		redraw | echom " Remove Trailing Spaces: REMOVED!"
	catch
		redraw | echom " Remove Trailing Spaces: NONE FOUND."
	endtry
	call setpos('.',l:pos)
endfunction

" put <COUNT> blank lines above/below the current line.
function! my#MakeRoom(direction,number=1)
	let l:command = "norm " .
				\ ( a:direction=='above' ? 'O' : 'o' ) .
				\ repeat( "\<CR>", a:number-1 ) .
				\ "\<Esc>"
	let l:line = line(".") + ( a:direction=="above" ? a:number : 0 )
	let l:col  = col(".")
	silent exec l:command
	call cursor(l:line, l:col)
endfunction

" change the 'Last Modified' date automatically. The pattern provided must
" match the entirety of the 'Last Modified' part including the old date. The
" pattern must contain 2 capture groups, the 2 groups will be reused at the
" beginning and the end of the substitution.
" Example:
"     - 'Last Modified' part:    date: "1999-02-10"
"     - pattern:                 ^\(date:\s\{-}"\).\{-}\(".*\)$
function! my#LastMod(pattern, line=6)
	let l:pos = getpos(".")
	exec "1,".a:line.'g/'.a:pattern.'/s/'.a:pattern.'/\1'.strftime("%F").'\2'
	call setpos(".", l:pos)
endfunction

" resize stacking panes like tmux
function! my#Resize2Panes(key, size=5) abort
	let l:up   = win_screenpos(winnr())[0] <= 2
	let l:left = win_screenpos(winnr())[1] <= 1
	if     a:key=="Up"    | exe      "resize" .. ( l:up   ? "-" : "+" ) .. a:size
	elseif a:key=="Down"  | exe      "resize" .. ( l:up   ? "+" : "-" ) .. a:size
	elseif a:key=="Left"  | exe "vert resize" .. ( l:left ? "-" : "+" ) .. a:size
	elseif a:key=="Right" | exe "vert resize" .. ( l:left ? "+" : "-" ) .. a:size
	endif
endfunction

" create a scratch buffer
function! my#Scratch(height=5)
	new
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
	resize -1000
	execute "resize +" .. max([a:height-1,0])
endfunction

" quote a string
function! my#quote(string, type=1)
	let l:quote = a:type==1 ? "'" : '"'
	return l:quote .. a:string .. l:quote
endfunction

""" Toggle Settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" toggles spelling, ignoring Chinese characters.
function! my#Spell(set="", de=0)
	if a:set==""
		setlocal spell!
	else
		execute "setlocal " .. ( a:set ? "" : "no" ) .. "spell"
	endif
	execute "setlocal spelllang=en" .. ( a:de ? ",de" : "" )
	setlocal spelllang+=cjk
	setlocal spell?
endfunction

" change the display width of a tab.
function! my#TabSize(size)
	exec "setlocal noexpandtab"
	exec "setlocal shiftwidth="  . a:size
	exec "setlocal softtabstop=" . a:size
	exec "setlocal tabstop="     . a:size
endfunction

" toggle line number options
function! my#ToggleLineNumber()
	let l:num  = matchstr(execute('set number?'),        'no')
	let l:rnum = matchstr(execute('set relativenumber?'),'no')
	if     l:num==''   && l:rnum==''   | set norelativenumber | echo "> Line Number:     number & [NO]relativenumber"
	elseif l:num==''   && l:rnum=='no' | set nonumber         | echo "> Line Number: [NO]number & [NO]relativenumber"
	elseif l:num=='no' && l:rnum=='no' | set relativenumber   | echo "> Line Number: [NO]number &     relativenumber"
	elseif l:num=='no' && l:rnum==''   | set number           | echo "> Line Number:     number &     relativenumber"
	endif
endfunction

" toggle virtual edit
function! my#ToggleVirtualEdit()
	if &virtualedit==#'all' | set virtualedit=NONE | echo " Virtual: Off"
	else                    | set virtualedit=all  | echo " Virtual: On"
	endif
endfunction

function! my#FocusCursor(on)
	if a:on | set   cursorline   cursorcolumn
	else    | set nocursorline nocursorcolumn
	endif
endfunction

""" Arguments and Functions """""""""""""""""""""""""""""""""""""""""""""""""""

" Delete surrounding function calls: 'print(...)' --> '...'. A function assumes
" the form "<HEAD><BODY>\{-}<BRACKETS_OPEN>...<BRACKETS_CLOSE>".
" Testing: funcOne(aa, funcTwo(bb, funcThree(cc)), dd, funcFour(hh, funcFive(ee), gg), ff)
function! my#DelFuncCall(head='[a-zA-Z]', body='[a-zA-Z0-9]', brackets='()')
	let l:col  = col(".") - 1
	let l:line = getline(".")
	for l:i in range(strlen(l:line))
		let l:char = l:line[l:col + l:i]
		if  l:char=~a:head && l:i==0 | continue | endif
		if  l:char=~a:body           | continue | endif
		if  l:char==a:brackets[0]    | break    | endif
		execute 'norm va'.a:brackets[0]."o\<Esc>"
		break
	endfor
	call search(a:head.a:body.'\{-}'.a:brackets[0], 'cb')
	exec 'norm dt'.a:brackets[0]
	call surround#Delete()
endfunction

" Select in an argument of a function.
" Assumptions:
" - All the brackets are balanced, i.e., no single brackets in string, etc.
" - The cursor is not placed on a separator ( often a comma ).
function! my#SelectArgument(type='i',open='(\|[',close=')\|]',sep=',')
	let l:col  = col(".") - 1
	let l:line = getline(".")
	let [ l:begin, l:end ] = [ 0, 0 ]
	" Looking backwards
	let l:bracket_count = 0
	if line[l:col]=~a:close | let l:bracket_count+=1 | endif
	for l:i in range(strlen(l:line)) | let l:i+=1
		let l:curr = l:col - l:i
		let l:char = l:line[l:curr]
		if l:char=~a:close                      | let l:bracket_count+=1   | continue | endif
		if l:char=~a:open && l:bracket_count!=0 | let l:bracket_count-=1   | continue | endif
		if l:bracket_count!=0                                              | continue | endif
		if l:char=~a:sep.'\|'.a:open            | let l:begin = l:curr + 2 | break    | endif
	endfor
	" Looking forwards
	let l:bracket_count = 0
	if line[l:col]=~a:open | let l:bracket_count += 1 | endif
	for l:i in range(strlen(l:line)) | let l:i += 1
		let l:curr = l:col + l:i
		let l:char = l:line[l:curr]
		if l:char=~a:open                        | let l:bracket_count+=1 | continue | endif
		if l:char=~a:close && l:bracket_count!=0 | let l:bracket_count-=1 | continue | endif
		if l:bracket_count!=0                                             | continue | endif
		if l:char=~a:sep.'\|'.a:close            | let l:end = l:curr     | break    | endif
	endfor
	" Type 'i' or 'a'
	if     a:type=='a' && l:line[l:end]    =~a:sep | let l:end   += 1
	elseif a:type=='a' && l:line[l:begin-2]=~a:sep | let l:begin -= 1
	endif
	" Do something
	call cursor(l:line,l:begin)
	exec 'norm! v' . ( l:end - l:begin ) . 'l'
endfunction

""" Git """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight git merge conflict.
let g:my_git_conflict_highlight = 0
function! my#GitConflictHighlight()
	if !g:my_git_conflict_highlight
		match GitConflict /^\(<<<<<<<.*\|=======\|>>>>>>>.*\)$/
		highlight GitConflict ctermbg=red ctermfg=white
		execute "let b:match_words" .
					\ ( exists("b:match_words") ? "+=" : "=" ) . "'" .
					\ ( exists("b:match_words") ? "," : "" ) .
					\ '\(<<<<<<<\):\(=======\):\(>>>>>>>\)' . "'"
		let g:my_git_conflict_highlight = 1
		redraw | echom "--> Git Merge Conflict Highlighted: ON"
	else
		match
		silent syntax clear GitConflict
		let g:my_git_conflict_highlight = 0
		redraw | echom "--> Git Merge Conflict Highlight: OFF"
	endif
endfunction
