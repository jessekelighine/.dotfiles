" start R console and get the buffer numbers.
function! r#StartConsole()
	let g:r_script_bufnr = bufnr()
	split below | term R
	let g:r_console_bufnr = bufnr()
	let g:r_console_job_id = b:terminal_job_id
	exec "sbuffer ".g:r_script_bufnr
	call r#ResizeConsole()
	call r#MoveConsole()
endfunction

" close R console and get the buffer numbers.
function! r#CloseConsole(hard=1)
	if a:hard | call execute("bd! ".g:r_console_bufnr)
	else
		exec "sbuffer ".g:r_console_bufnr
		call feedkeys("a\<C-D>")
	endif
endfunction

" clear R console
function! r#ClearConsole()
	call jobsend(g:r_console_job_id, "\<C-L>")
endfunction

" move the console to the bottom.
function! r#MoveConsole()
	exec "sbuffer ".g:r_console_bufnr
	exec "norm G"
	exec "sbuffer ".g:r_script_bufnr
endfunction

function! r#ResizeConsole()
	exec "resize +100"
	exec "resize -5"  
endfunction

"### Send Lines to Console ####################################################

function! r#SendLine()
	call jobsend(g:r_console_job_id, getline(".")."\n")
	call r#MoveConsole()
endfunction

function! r#SendVisual() range
	exec 'normal! `<v`>"ry'
	call jobsend(g:r_console_job_id, @r."\n")
	call r#MoveConsole()
endfunction

function! r#PrintObject()
	exec 'norm viw"ry'
	call jobsend(g:r_console_job_id, 'print('.@r.')'."\n")
	call r#MoveConsole()
endfunction

function! r#ListObjects()
	call jobsend(g:r_console_job_id, 'ls()'."\n")
	call r#MoveConsole()
endfunction
