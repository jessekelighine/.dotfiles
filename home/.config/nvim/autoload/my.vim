" my.vim

""" Snippets """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! my#GetSnippets(type, name, args={})
	let [ l:begin, l:lines ] = [ line("."), line("$") ]
	exe "read " .. $HOME .. "/.config/nvim/snippets/" .. a:type .. "/" .. a:name
	let l:end = l:begin + ( line("$") - l:lines ) - 1
	call cursor(l:begin,0)
	exe "norm! dd"
	let l:do_indent = has_key(a:args, "indent") ? a:args.indent : 1
	let l:do_begin  = has_key(a:args, "begin")  ? a:args.begin  : 1
	if  l:do_indent | exec l:begin .. "," .. l:end .. "norm! v=" | endif
	if  l:do_begin  | call cursor(l:begin, 0)                    | endif
endfunction

function! my#GetAuthor()
 	let l:path = expand("~/.config/nvim/snippets/website")
	return readfile(l:path)[0]
endfunction

""" Miscellaneous """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" clear all registers
function! my#FlushRegisters()
	let l:registers = split(
				\ '/-"'
				\ .. '0123456789'
				\ .. 'abcdefghijklmnopqrstuvwxyz'
				\ .. 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
				\ '\zs')
	for l:register in l:registers
		call setreg(l:register, [])
	endfor
endfunction

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
		silent execute join([a:line1,a:line2],',') .. 's/^\(.\{-}\)\s\+$/\1/g'
		redraw | echom " Remove Trailing Spaces: REMOVED!"
	catch
		redraw | echom " Remove Trailing Spaces: NONE FOUND."
	endtry
	call setpos('.',l:pos)
endfunction

" put <COUNT> blank lines above/below the current line.
function! my#MakeRoom(direction,number=1)
	let l:command = "norm "
				\ .. ( a:direction=='above' ? 'O' : 'o' )
				\ .. repeat( "\<CR>", a:number-1 )
				\ .. "\<Esc>"
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
function! my#LastMod(pattern, line=min([line("$"), 5])) abort
	let l:pos = getpos(".")
	let l:command = join([
				\ "keeppatterns",
				\ "1," .. a:line,
				\ "s/" .. a:pattern .. '/\1' .. strftime("%F") .. '\2/e'
				\ ])
	silent execute l:command
	silent call setpos(".", l:pos)
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

""" Toggle Settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" toggles spelling, ignoring Chinese characters.
function! my#Spell(set="", de=0)
	if a:set==""
		setlocal spell!
	else
		execute "setlocal " .. ( a:set ? "" : "no" ) .. "spell"
	endif
	execute "setlocal spelllang=en" .. ( a:de ? ",de" : "" )
	call chinese#Spell()
	setlocal spell?
endfunction

" change the display width of a tab.
function! my#TabSize(size)
	exec "setlocal noexpandtab"
	exec "setlocal shiftwidth="  .. a:size
	exec "setlocal softtabstop=" .. a:size
	exec "setlocal tabstop="     .. a:size
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
