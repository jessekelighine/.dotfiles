" autoload/matlab.vim

" Open Tmux Pane as Matlab REPL.
function! matlab#REPL(start)
	packadd! vim-slime
	if a:start && vimslime#Target()==""
		let l:command = 'tmux split -c "$PWD";'
					\ . "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';"
					\ . 'tmux last-pane;'
		let l:targets = system(l:command)->split('\n')->map('split(v:val," ")')
		for l:pane in l:targets | if l:pane[1]==1 | break | endif | endfor
		call vimslime#SetTarget(l:pane[0])
		call vimslime#Send('matlab', 1)
	elseif !a:start && vimslime#Target()!=""
		call vimslime#Send("exit;\nexit", 1)
		call vimslime#UnsetTarget()
	endif
endfunction

" Get line numbers of section headings.
" let l:list = [] | global/^%%/let l:list = l:list + [ line('.') ]
function! <SID>GetSection()
	let l:list = []
	for l:line in range(line('$')) | let l:line += 1
		if match(getline(l:line),'^%%') != -1 
			let l:list = l:list + [	l:line ]
		endif
	endfor
	return l:list
endfunction

" Visual select a "section" defined by matlab.
" type = { "a", "i" }.
function! matlab#GetSection(type='a')
	let l:line = line('.')
	let l:list = [ 0 ] + <SID>GetSection() + [ line('$')+1 ]
	for l:i in range(len(l:list)-1)
		let [ l:begin, l:end ] = [ l:list[l:i], l:list[l:i+1]-1 ]
		if l:begin<=l:line && l:line<=l:end | break | endif
	endfor
	let l:begin = l:begin==0 ? 1 : l:begin + ( a:type=='a' ? 0 : 1 )
	if l:end-l:begin<0 | throw "Invlaid select range." | endif
	call cursor(l:begin, 0)
	exec { x -> "norm! V" . ( x==0 ? "" : x."j" ) }( l:end-l:begin )
endfunction
