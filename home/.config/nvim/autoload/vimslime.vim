" autoload/vimslime.vim

let b:vimslime_target = ""
let b:vimslime_tmux_close_command = repeat("\<C-C>", 5) .. repeat("\<C-D>", 5)

" Tmux: Open Pane
function! vimslime#OpenTmux(command="", resize_pane='-U 12', close_command="") abort
	if b:vimslime_target != ""
		call system("tmux resize-pane -Z")
		return
	endif
	if a:close_command != ""
		let b:vimslime_tmux_close_command = a:close_command
	endif
	let l:command = join([
				\ 'tmux split -c "$PWD";',
				\ 'tmux resize-pane ' .. a:resize_pane .. ';',
				\ "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';",
				\ 'tmux last-pane;'
				\ ])
	let b:vimslime_target = system(l:command)
				\ ->split('\n')
				\ ->map({ key, val -> split(val, " ") })
				\ ->filter({ key, val -> val[1] == 1 })
				\ ->{ x -> x[0][0] }()
	call join(["sleep", ".2s"])->system() " wait just a moment for zshrc or bashrc to fully load
	call vimslime#Send(a:command, 1)
	augroup VimslimeOpenTmux
		autocmd!
		autocmd VimLeave * exe b:vimslime_target == "" ? "" : 'call vimslime#CloseTmux()'
	augroup END
endfunction

" Tmux: Close Pane
function! vimslime#CloseTmux(command="")
	let l:command = a:command == "" ? b:vimslime_tmux_close_command : a:command
	call vimslime#Send(l:command, 1)
	call system("tmux kill-pane -t " .. b:vimslime_target)
	let b:vimslime_target = ""
endfunction

" Set Target Tmux Pane
function! vimslime#SetTarget(target='') abort
	let b:vimslime_target = a:target != "" ? a:target : input("session:window.pane> ", "", "custom,vimslime#PaneNames")
endfunction

" List Tmux Panes
function! vimslime#PaneNames(ArgLead, CmdLine, CursorPos) abort
	return system("tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}'")
endfunction

" Escape Text
function! <SID>EscapeText(text) abort
	return substitute(a:text, "'", "'\\\\''", 'g')
endfunction

" Send Text to Tmux Pane.
function! vimslime#Send(text, return=0) abort
	if b:vimslime_target == "" | call vimslime#SetTarget() | end
	let l:text = "'" .. <SID>EscapeText(a:text) .. ( a:return ? "\n" : "" ) .. "'"
	let l:command = join(["tmux send-keys -t", b:vimslime_target, l:text])
	echo system(l:command)
endfunction

" Wraper for vimslime#Send
function! vimslime#Forward(type, return=v:null, wrapper={ x -> x }) range
	let l:types = {
				\ "line":      { "pre": "",   "yank": "yy",  "return": 0 },
				\ "paragraph": { "pre": "",   "yank": "yip", "return": 0 },
				\ "selection": { "pre": "gv", "yank": "y",   "return": 1 },
				\ "word":      { "pre": "",   "yank": "yiw", "return": 1 },
				\ "end":       { "pre": "VG", "yank": "y",   "return": 0 },
				\ }
	let l:type = l:types[a:type]
	let l:return = a:return is v:null ? l:type.return : a:return
	let l:command = [
				\ "norm! m'" .. l:type.pre .. '"9' .. l:type.yank,
				\ "norm! `'"
				\ ]
	silent exec "norm! \<Esc>"
	silent exec l:command[0]
	silent call vimslime#Send(a:wrapper(@9), l:return) 
	silent exec l:command[1]
endfunction
