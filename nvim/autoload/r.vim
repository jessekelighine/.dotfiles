" ~/.config/nvim/autoload/r.vim

" expand pipe symbol
if !exists("b:r_pipe_type") | let b:r_pipe_type = "|>" | endif
function! r#PipeExpand(type, symbol=b:r_pipe_type)
	exec   'norm! a' . ( getline(".")[col(".")-1]!=" " ? " " : "" ) . a:symbol
	if     a:type=='CR'  | call feedkeys( "a\<CR>" )
	elseif a:type=='Tab' | call feedkeys( "a" . ( getline(".")[col(".")]==" " ? "" : " " ) )
	endif
endfunction

" expand curly braces
function! r#CurlyExpand()
	let l:temp = { x -> x[col("."):(len(x)-1)] }( getline(".") )
	let l:temp = empty(l:temp) || l:temp ==# ' \+'
	if  l:temp | call feedkeys("a{}\<Esc>i\<CR>\<Esc>\<S-O>")
	else       | call feedkeys(( col(".")==1 ? "i" : "a" ) . "{\<Esc>a\<CR>")
	endif
endfunction

" explain "dcast" and "melt" from data.table
function! r#DatatableExplain(name)
	exec "split $HOME/.config/nvim/snippets/r/datatable-" . a:name . ".md"
endfunction
function! r#DatatableExplainComplete(ArgLead, CmdLine, CursorPos)
	return "dcast"."\n"."melt"
endfunction
