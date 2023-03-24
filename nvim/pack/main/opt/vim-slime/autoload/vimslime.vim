" autoload/vimslime.vim

" Send "a:text" to a tmux pane.
function! vimslime#Send(text, return=0) abort
	if !exists("b:vimslime_id") | call vimslime#SetPane() | end
	let l:cmd = "'" . substitute(a:text, "'", "'\\\\''", 'g') . ( a:return ? "\n" : "" ) . "'"
	echo system("tmux send-keys -t ".b:vimslime_id." ".l:cmd)
endfunction

" Figure out which tmux pane to send the text to.
function! vimslime#SetPane() abort
	let b:vimslime_id = input("session:window.pane> ","","custom,vimslime#PaneNames")
endfunction

" Get a list of active panes of tmux.
function! vimslime#PaneNames(A,L,P) abort
	return system("tmux list-panes -a | awk -F : '{ printf \"%s:%s\\n\", $1, $2 }'")
endfunction
