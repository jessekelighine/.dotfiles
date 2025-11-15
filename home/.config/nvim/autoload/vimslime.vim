" ~/.config/nvim/autoload/vimslime.vim

function! <SID>target_exists()
	if !exists("b:vimslime_target") | return 0 | endif
	if b:vimslime_target == "" | return 0 | endif
	return 1
endfunction

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
	let l:kill_command = "call system('tmux kill-pane -t " .. b:vimslime_target .. "')"
	execute "autocmd VimLeave * ++once " .. l:kill_command
endfunction

function! vimslime#Close()
	if !<SID>target_exists() | return | endif
	call system("tmux kill-pane -t " .. b:vimslime_target)
	unlet b:vimslime_target
endfunction

function! vimslime#Send(text, return=0) abort
	if !<SID>target_exists() | return | endif
	let l:escaped_text = substitute(a:text, "'", "'\\\\''", 'g')
	let l:text_to_send = "'" .. l:escaped_text .. ( a:return ? "\n" : "" ) .. "'"
	let l:command = "tmux send-keys -t " .. b:vimslime_target .. " -- " .. l:text_to_send
	call system(l:command)
endfunction

function! vimslime#Forward(type, opts={}) range
	let l:return = get(a:opts, 'return', 0)
	let l:Wrapper = get(a:opts, 'wrapper', { x -> x })
	let l:types = {
				\ "line":      { "pre": "",   "yank": "yy"  },
				\ "paragraph": { "pre": "",   "yank": "yip" },
				\ "selection": { "pre": "gv", "yank": "y"   },
				\ "word":      { "pre": "",   "yank": "yiw" },
				\ "end":       { "pre": "VG", "yank": "y"   },
				\ }
	silent exec "norm! \<Esc>"
	silent exec "norm! m'" .. l:types[a:type].pre .. '"9' .. l:types[a:type].yank
	silent call vimslime#Send(l:Wrapper(@9), l:return) 
	silent exec "norm! `'"
endfunction
