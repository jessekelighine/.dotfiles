" ~/.config/nvim/after/plugin/toggleset.vim

" change the display width of a tab.
function! <SID>TabSize(size)
	execute "setlocal noexpandtab"
	execute "setlocal shiftwidth="  .. a:size
	execute "setlocal softtabstop=" .. a:size
	execute "setlocal tabstop="     .. a:size
endfunction

" toggles spelling, ignoring Chinese characters.
function! <SID>ToggleSpell(set = "", de = 0)
	if a:set == ""
		setlocal spell!
	else
		execute "setlocal " .. ( a:set ? "" : "no" ) .. "spell"
	endif
	execute "setl spelllang=en" .. ( a:de ? ",de" : "" )
	setlocal spelllang+=cjk
	setlocal spell?
endfunction

" toggle line number options
function! <SID>ToggleLineNumber()
	let l:num  = matchstr(execute('set number?'),        'no')
	let l:rnum = matchstr(execute('set relativenumber?'),'no')
	if     l:num==''   && l:rnum==''   | set norelativenumber | echo "> Line Number:     number & [NO]relativenumber"
	elseif l:num==''   && l:rnum=='no' | set nonumber         | echo "> Line Number: [NO]number & [NO]relativenumber"
	elseif l:num=='no' && l:rnum=='no' | set relativenumber   | echo "> Line Number: [NO]number &     relativenumber"
	elseif l:num=='no' && l:rnum==''   | set number           | echo "> Line Number:     number &     relativenumber"
	endif
endfunction

" toggle virtual edit
function! <SID>ToggleVirtualEdit()
	if &virtualedit==#'all' | set virtualedit=NONE | echo " Virtual: Off"
	else                    | set virtualedit=all  | echo " Virtual: On"
	endif
endfunction

" toggle focus cursor
function! <SID>ToggleFocusCursor()
	let l:focused = &cursorline || &cursorcolumn
	if l:focused
		set nocursorline nocursorcolumn
	else
		set cursorline cursorcolumn
	endif
endfunction

command! -nargs=0 FocusCursorToggle call <SID>ToggleFocusCursor()
command! -nargs=0 LineNumberToggle  call <SID>ToggleLineNumber()
command! -nargs=0 VirtualEditToggle call <SID>ToggleVirtualEdit()
command! -nargs=? SpellToggle       call <SID>ToggleSpell(<args>)
command! -nargs=1 TabSize           call <SID>TabSize(<args>)

nnoremap <silent> <leader>s  <Cmd>SpellToggle<CR>
nnoremap <silent> <leader>l  <Cmd>set list!<CR>
