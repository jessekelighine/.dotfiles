" ~/.config/nvim/autoload/vimslime.vim

let b:vimslime_target = ""

function! <SID>target_exists()
	if !exists("b:vimslime_target") | return 0 | endif
	if b:vimslime_target == "" | return 0 | endif
	return 1
endfunction

" Open Split Tmux Pane
function! vimslime#Open(command="", tmux_flags="") abort
	if <SID>target_exists()
		call system("tmux resize-pane -Z")
		return
	endif
	let l:command = join([
				\ 'tmux split-window -c "$PWD" -P -F "#{pane_id}" ' .. a:tmux_flags .. ';',
				\ 'tmux last-pane;'
				\ ])
	let b:vimslime_target = system(l:command)->substitute("\n", "", "")
	call system("sleep .2s") " wait for zshrc or bashrc to load
	call vimslime#Send(a:command, 1)
	let l:tmux_kill_command = "tmux kill-pane -t " .. b:vimslime_target
	execute "autocmd VimLeave * ++once call system('" .. l:tmux_kill_command .. "')"
endfunction

" Close Split Tmux Pane
function! vimslime#Close()
	if !<SID>target_exists() | return | endif
	call system("tmux kill-pane -t " .. b:vimslime_target)
	let b:vimslime_target = ""
endfunction

" Send Text to Tmux Pane.
function! vimslime#Send(text, return=0) abort
	if !<SID>target_exists() | return | endif
	let l:escaped_text = substitute(a:text, "'", "'\\\\''", 'g')
	let l:text = "'" .. l:escaped_text .. ( a:return ? "\n" : "" ) .. "'"
	let l:command = "tmux send-keys -t " .. b:vimslime_target .. " " .. l:text
	call system(l:command)
endfunction

" Wraper for vimslime#Send
function! vimslime#Forward(type, return=0, wrapper={ x -> x }) range
	let l:types = {
				\ "line":      { "pre": "",   "yank": "yy",  "return": 0 },
				\ "paragraph": { "pre": "",   "yank": "yip", "return": 0 },
				\ "selection": { "pre": "gv", "yank": "y",   "return": 1 },
				\ "word":      { "pre": "",   "yank": "yiw", "return": 1 },
				\ "end":       { "pre": "VG", "yank": "y",   "return": 0 },
				\ }
	let l:type = l:types[a:type]
	let l:return = a:return ? l:type.return : a:return
	silent exec "norm! \<Esc>"
	silent exec "norm! m'" .. l:type.pre .. '"9' .. l:type.yank,
	silent call vimslime#Send(a:wrapper(@9), l:return) 
	silent exec "norm! `'"
endfunction
