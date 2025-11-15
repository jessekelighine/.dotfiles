" ~/.config/nvim/autoload/terminal.vim

function! <SID>terminal_exits() abort
	return exists("b:terminal_target_bufnr") && exists("b:terminal_target_channel")
endfunction

function! terminal#Open(cmd="") abort
	if exists('b:terminal_target_bufnr')
		execute "buffer" .. b:terminal_target_bufnr
		return
	endif
	let l:home_bufnr = bufnr("%")
	enew
	call setbufvar(l:home_bufnr, 'terminal_target_bufnr', bufnr("%"))
	setlocal nonumber
	setlocal norelativenumber
	terminal
	call setbufvar(l:home_bufnr, 'terminal_target_channel', &channel)
	sleep 100m
	call chansend(&channel, a:cmd .. "\n")
	augroup TerminalOpen
		autocmd!
		autocmd BufWinEnter,WinEnter term://* normal! 1000000j
	augroup END
endfunction

function! terminal#Close() abort
	if !<SID>terminal_exits() | return | endif
	augroup! TerminalOpen
	execute "bdelete! " .. b:terminal_target_bufnr
	unlet b:terminal_target_bufnr
	unlet b:terminal_target_channel
endfunction

function! terminal#Send(cmd, return=0) abort
	if !<SID>terminal_exits() | return | endif
	let l:return = a:return ? "\n" : ""
	call chansend(b:terminal_target_channel, a:cmd .. l:return)
endfunction

function! terminal#Forward(type, opts) range
	let l:return = get(a:opts, 'return', 0)
	let l:wrapper = get(a:opts, 'wrapper', { x -> x })
	let l:types = {
				\ "line":      { "pre": "",   "yank": "yy"  },
				\ "paragraph": { "pre": "",   "yank": "yip" },
				\ "selection": { "pre": "gv", "yank": "y"   },
				\ "word":      { "pre": "",   "yank": "yiw" },
				\ "end":       { "pre": "VG", "yank": "y"   },
				\ }
	silent exec "norm! \<Esc>"
	silent exec "norm! m'" .. l:types[a:type].pre .. '"9' .. l:types[a:type].yank
	silent call terminal#Send(a:wrapper(@9), l:return)
	silent exec "norm! `'"
endfunction
