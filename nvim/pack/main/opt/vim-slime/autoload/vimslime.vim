" autoload/vimslime.vim

" Send "a:text" to a tmux pane.
function! vimslime#send_to_pane(text)
	if !exists("b:vimslime_tmux_target") | call vimslime#tmux_vars() | end
	echo system("tmux send-keys -t " . b:vimslime_tmux_target . " '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
endfunction

" Get a list of active panes of tmux.
function! vimslime#tmux_pane_names(A,L,P)
	return system("tmux list-panes -a | awk -F : '{ printf \"%s:%s\\n\", $1, $2 }'")
endfunction

" Figure out which tmux pane to send the text to.
function vimslime#tmux_vars()
	if !exists("b:vimslime_tmux_target") | let b:vimslime_tmux_target = "%1" | end
	echo system("tmux list-panes -a | awk -F : '{ printf \"%s:%s\\n\", $1, $2 }'")
	let b:vimslime_tmux_target = input("session:window.pane> ", "", "custom,vimslime#tmux_pane_names")
endfunction
