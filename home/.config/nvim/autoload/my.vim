" my.vim

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
		exec join(["source", a:filename])
	endif
endfunction

" remove trailing white spaces.
function! my#RemoveTrailingSpaces(line1=1,line2=line('$'))
	let l:pos = getpos(".")
	try
		let l:range = join([a:line1, a:line2], ',')
		let l:command = l:range .. 's/^\(.\{-}\)\s\+$/\1/g'
		silent exec l:command
		redraw | echom " Remove Trailing Spaces: REMOVED!"
	catch
		redraw | echom " Remove Trailing Spaces: NONE FOUND."
	endtry
	call setpos('.', l:pos)
endfunction

" put <COUNT> blank lines above/below the current line.
function! my#MakeRoom(direction,number=1)
	let l:command = join([
				\ "norm!",
				\ a:direction == "above" ? "O" : "o",
				\ repeat("\<CR>", a:number - 1),
				\ "\<Esc>"
				\ ])
	let l:line = line(".") + ( a:direction == "above" ? a:number : 0 )
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
	exec "setl spelllang=en" .. ( a:de ? ",de" : "" )
	call chinese#Spell()
	setl spell?
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
