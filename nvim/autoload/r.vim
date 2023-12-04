" ~/.config/nvim/autoload/r.vim

" Toggle between two pipes: `%>%` and `|>`.
function! r#PipeSwitch()
	if !exists("b:r_pipe_type") || b:r_pipe_type == '%>%'
		inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
		inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
		let b:r_pipe_type = '|>'
		redraw | echom " Pipe: |>"
	else
		inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab',"%>%")<CR>
		inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR',"%>%")<CR>
		let b:r_pipe_type = '%>%'
		redraw | echom " Pipe: %>%"
	endif
endfunction

" Visual select a "section" defined by matlab.
" type = { "a", "i" }.
function! r#GetSection(type='a')
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
" Get line numbers of section headings.
" let l:list = [] | global/^%%/let l:list = l:list + [ line('.') ]
function! <SID>GetSection()
	let l:patt = '^###'
	let l:list = []
	for l:line in range(line('$')) | let l:line += 1
		if match(getline(l:line),l:patt) != -1
			let l:list = l:list + [	l:line ]
		endif
	endfor
	return l:list
endfunction

" expand pipe symbol
function! r#PipeExpand(type, symbol="|>")
	execut 'norm! a' . ( getline(".")[col(".")-1]!=" " ? " " : "" ) . a:symbol
	if     a:type=='CR'  | call feedkeys( "a\<CR>" )
	elseif a:type=='Tab' | call feedkeys( "a" . ( getline(".")[col(".")]==" " ? "" : " " ) )
	endif
endfunction

" explain "dcast" and "melt" from data.table
function! r#DatatableExplain(name)
	exec "split $HOME/.config/nvim/snippets/r/datatable-" . a:name . ".md"
endfunction
function! r#DatatableExplainComplete(ArgLead, CmdLine, CursorPos)
	return "dcast"."\n"."melt"
endfunction
