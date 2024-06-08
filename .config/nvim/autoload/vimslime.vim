" autoload/vimslime.vim

""" Manipulate Panes """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tmux: Open pane
function! vimslime#OpenTmux(command="") abort
	if vimslime#Target()!="" || a:command=="" | call system("tmux resize-pane -Z") | return | endif
	let l:command =  'tmux split -c "$PWD";'
				\ .. 'tmux resize-pane -U 12;'
				\ .. "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';"
				\ .. 'tmux last-pane;'
	let l:target_pane = system(l:command)->split('\n')->map('split(v:val," ")')->filter('v:val[1]==1')
	call vimslime#SetTarget(l:target_pane[0][0])
	call vimslime#Send(a:command, 1)
	augroup VimslimeOpenTmux
		autocmd!
		autocmd VimLeave * exe vimslime#Target()=="" ? "" : 'call vimslime#CloseTmux()'
	augroup END
endfunction

" Tmux: Close pane
function! vimslime#CloseTmux()
	call vimslime#Send(repeat("\<C-C>", 10) .. "exit", 1)
	call vimslime#UnsetTarget()
endfunction

""" Simple Commands """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Send "a:text" to a tmux pane.
function! vimslime#Send(text, return=0) abort
	if vimslime#Target()=="" | call vimslime#SetTarget() | end
	let l:command = "'" .. substitute(a:text, "'", "'\\\\''", 'g') .. ( a:return ? "\n" : "" ) .. "'"
	echo system("tmux send-keys -t " .. g:vimslime_target .. " " .. l:command)
endfunction

" Get the vimslime target if it exists.
function! vimslime#Target() abort
	return exists("g:vimslime_target") ? g:vimslime_target : ""
endfunction

" Figure out which tmux pane to send the text to.
function! vimslime#SetTarget(target='') abort
	let g:vimslime_target = a:target != "" ? a:target : input("session:window.pane> ","","custom,vimslime#PaneNames")
endfunction

" Remove variabel g:vimslime_target
function! vimslime#UnsetTarget() abort
	unlet g:vimslime_target
endfunction

" Get a list of active panes of tmux.
function! vimslime#PaneNames(ArgLead, CmdLine, CursorPos) abort
	return system("tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}'")
endfunction
