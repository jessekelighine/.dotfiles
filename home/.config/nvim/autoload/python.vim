" ~/.config/nvim/autoload/python.vim

" Open Tmux Pane as Matlab REPL.
" function! py#REPL(start)
" 	packadd! vim-slime
" 	let l:init_command = 'python'
" 	if a:start && vimslime#Target()==""
" 		let l:command = 'tmux split -c "$PWD";'
" 					\ . "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';"
" 					\ . 'tmux last-pane;'
" 		let l:targets = system(l:command)->split('\n')->map('split(v:val," ")')
" 		for l:pane in l:targets | if l:pane[1]==1 | break | endif | endfor
" 		call vimslime#SetTarget(l:pane[0])
" 		call vimslime#Send(l:init_command, 1)
" 	elseif !a:start && vimslime#Target()!=""
" 		call vimslime#Send("exit()", 1)
" 		call vimslime#Send("exit", 1)
" 		call vimslime#UnsetTarget()
" 	endif
" endfunction
