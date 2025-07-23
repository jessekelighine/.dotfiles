" ~/.config/nvim/autoload/terminal.vim

" open a temporary terminal to run command.
function! terminal#Open(cmd, height=10)
	execute a:height .. 'new'
	call termopen(a:cmd, { 'on_exit': 'terminal#Close' })
	let g:terminal_temp_terminal_bn = bufnr('%')
	execute 'normal G'
	execute 'wincmd p'
	nnoremap <Space> <Cmd>exec "bdelete!" .. g:terminal_temp_terminal_bn<CR>
endfunction

" (on) exit the temporary terminal.
function! terminal#Close(job_id, data, event, key='<Space>') dict
	try | call  execute('bdelete '.g:terminal_temp_terminal_bn) | catch | endtry
	try | unlet g:terminal_temp_terminal_bn                     | catch | endtry
	try | call  execute('nunmap <buffer> <Space>')              | catch | endtry
	redraw | echo ''
endfunction
