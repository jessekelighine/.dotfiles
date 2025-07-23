" ~/.config/nvim/after/plugin/misc.vim

" remove trailing white spaces.
function! <SID>RemoveTrailingSpaces(line1 = 1,line2 = line('$'))
	let l:pos = getpos(".")
	try
		let l:range = join([a:line1, a:line2], ',')
		let l:command = join([
					\ "keepjumps",
					\ "keeppatterns",
					\  l:range .. 's/^\(.\{-}\)\s\+$/\1/g'
					\ ])
		silent execute l:command
		redraw | echom " Remove Trailing Spaces: REMOVED!"
	catch
		redraw | echom " Remove Trailing Spaces: NONE FOUND."
	endtry
	call setpos(".", l:pos)
endfunction

command! -nargs=0 SudoWrite            write ! sudo tee % > /dev/null " This only works for Vim, not NeoVim.
command! -nargs=* TallyOpacity         silent ! tally-opacity <args>
command! -nargs=0 RemoveTrailingSpaces call <SID>RemoveTrailingSpaces()

inoremap <expr> :date<Tab> strftime("%F")
inoremap <expr> :path<Tab> expand("%:p")
