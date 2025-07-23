" ~/.config/nvim/autoload/funcargs.vim
" ~/.config/nvim/after/plugin/funcargs.vim

" Delete surrounding function calls: 'print(...)' --> '...'. A function assumes
" the form "<HEAD><BODY>\{-}<BRACKETS_OPEN>...<BRACKETS_CLOSE>".
" Testing: funcOne(aa, funcTwo(bb, funcThree(cc)), dd, funcFour(hh, funcFive(ee), gg), ff)
function! funcargs#DeleteFunction(head='[a-zA-Z]', body='[a-zA-Z0-9]', brackets='()')
	let l:col  = col(".") - 1
	let l:line = getline(".")
	for l:i in range(strlen(l:line))
		let l:char = l:line[l:col + l:i]
		if  l:char =~ a:head && l:i == 0 | continue | endif
		if  l:char =~ a:body             | continue | endif
		if  l:char == a:brackets[0]      | break    | endif
		execute 'norm va' .. a:brackets[0] .. "o\<Esc>"
		break
	endfor
	call search(a:head .. a:body .. '\{-}' .. a:brackets[0], 'cb')
	exec 'norm! dt' .. a:brackets[0]
	call surround#Delete()
endfunction

" Select in an argument of a function.
" Assumptions:
" - All the brackets are balanced, i.e., no single brackets in string, etc.
" - The cursor is not placed on a separator ( often a comma ).
function! funcargs#SelectArgument(type='i', open='(\|[', close=')\|]', sep=',')
	let l:col  = col(".") - 1
	let l:line = getline(".")
	let [ l:begin, l:end ] = [ 0, 0 ]
	" Looking backwards
	let l:bracket_count = 0
	if line[l:col]=~a:close | let l:bracket_count+=1 | endif
	for l:i in range(strlen(l:line)) | let l:i+=1
		let l:curr = l:col - l:i
		let l:char = l:line[l:curr]
		if l:char=~a:close                      | let l:bracket_count+=1   | continue | endif
		if l:char=~a:open && l:bracket_count!=0 | let l:bracket_count-=1   | continue | endif
		if l:bracket_count!=0                                              | continue | endif
		if l:char=~a:sep.'\|'.a:open            | let l:begin = l:curr + 2 | break    | endif
	endfor
	" Looking forwards
	let l:bracket_count = 0
	if line[l:col]=~a:open | let l:bracket_count += 1 | endif
	for l:i in range(strlen(l:line)) | let l:i += 1
		let l:curr = l:col + l:i
		let l:char = l:line[l:curr]
		if l:char=~a:open                        | let l:bracket_count+=1 | continue | endif
		if l:char=~a:close && l:bracket_count!=0 | let l:bracket_count-=1 | continue | endif
		if l:bracket_count!=0                                             | continue | endif
		if l:char=~a:sep.'\|'.a:close            | let l:end = l:curr     | break    | endif
	endfor
	" Type 'i' or 'a'
	if     a:type=='a' && l:line[l:end]    =~a:sep | let l:end   += 1
	elseif a:type=='a' && l:line[l:begin-2]=~a:sep | let l:begin -= 1
	endif
	" Do something
	call cursor(l:line,l:begin)
	exec 'norm! v' . ( l:end - l:begin ) . 'l'
endfunction
