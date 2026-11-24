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
	sleep 200m " wait for zshrc or bashrc to load
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
	let l:text = a:text .. ( a:return ? "\n" : "" )
	let l:command = ["tmux", "send-keys", "-t", b:vimslime_target, "-l", "--", l:text]
	call system(l:command)
endfunction

function! vimslime#Paste(text, return=0) abort
	if !<SID>target_exists() | return | endif
	let l:buffer = "vimslime" .. b:vimslime_target
	call system(["tmux", "load-buffer", "-b", l:buffer, "-"], a:text)
	call system(["tmux", "paste-buffer", "-p", "-d", "-b", l:buffer, "-t", b:vimslime_target])
	if a:return | call vimslime#Send("", 1) | endif
endfunction

function! vimslime#Forward(type, opts={}) range abort
	let l:Wrapper = get(a:opts, "wrapper", { x -> x })
	let l:Sender  = get(a:opts, "paste", 0) ? function("vimslime#Paste") : function("vimslime#Send")
	let l:return  = get(a:opts, "return", 0)
	let l:view    = winsaveview()
	let l:saved   = getreginfo("9")
	let l:types   = {
				\ "line":      { "pre": "",   "yank": "yy"  },
				\ "paragraph": { "pre": "",   "yank": "yip" },
				\ "selection": { "pre": "gv", "yank": "y"   },
				\ "word":      { "pre": "",   "yank": "yiw" },
				\ "end":       { "pre": "VG", "yank": "y"   },
				\ }
	if !has_key(l:types, a:type)
		echohl ErrorMsg | echom "vimslime: unknown type " .. a:type | echohl None
		return
	endif
	try
		silent execute "normal! \<Esc>" .. l:types[a:type].pre .. '"9' .. l:types[a:type].yank
		let l:text = getreg("9")
	finally
		call setreg("9", l:saved)
		call winrestview(l:view)
	endtry
	call l:Sender(l:Wrapper(l:text), l:return)
endfunction
