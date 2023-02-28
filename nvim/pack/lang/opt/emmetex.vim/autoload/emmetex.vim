" autoload/texemmet.vim

let s:plus_optr     = '+'
let s:nest_optr     = '>'
let s:marker        = '<OPERAND_INSERT_MARKER>'
let s:optr_prcdnt   = { x -> s:is_nest_optr(x) ? 1 : ( s:is_plus_optr(x) ? 0 : -1 ) }
let s:pop_list      = { x -> remove(x,len(x)-1) }
let s:is_atom       = { x -> s:is_opnd(x) || s:is_optr(x) || s:is_clam(x) }
let s:is_list       = { x -> x=~'^\('.join(g:emmetex_lists,'\|').'\)$' }
let s:is_opnd       = { x -> x=~'^'.'\([a-z*]\+\)'.'\(\d\+\)*'.'\(\(\[\|{\).\{-}\(\]\|}\)\)*'.'$' }
let s:is_plus_optr  = { x -> x=~'^'.s:plus_optr.'$' }
let s:is_nest_optr  = { x -> x=~'^'.s:nest_optr.'$' }
let s:is_optr       = { x -> s:is_plus_optr(x) || s:is_nest_optr(x) }
let s:is_open_clam  = { x -> x=~'^($' }
let s:is_close_clam = { x -> x=~'^)$' }
let s:is_clam       = { x -> s:is_open_clam(x) || s:is_close_clam(x) }
let s:is_marker     = { x -> x=~#'^'.s:marker.'$' }
let s:opnd          = {
			\ 'body': { x -> matchstr(x,'^'.'\zs\([a-z*]\+\)\ze'.'\(\d\+\)*'.'\(\(\[\|{\).\{-}\(\]\|}\)\)*'.'$') },
			\ 'nums': { x -> matchstr(x,'^'.'\([a-z*]\+\)'.'\zs\(\d\+\)*\ze'.'\(\(\[\|{\).\{-}\(\]\|}\)\)*'.'$') },
			\ 'opts': { x -> matchstr(x,'^'.'\([a-z*]\+\)'.'\(\d\+\)*'.'\zs\(\(\[\|{\).\{-}\(\]\|}\)\)*\ze'.'$') },
			\ }

" Paranthesis Matcher: Find the position of mathing paranthesis in a string.
function! <SID>matchparenpos(string,pos)
	let l:base = a:string[a:pos]
	let l:pair = { '(':')', '[':']', '{':'}', ')':'(', ']':'[', '}':'{' }
	if     l:base=~#'(\|[\|{' | let l:range = range(a:pos+1,len(a:string)-1)
	elseif l:base=~#')\|]\|}' | let l:range = range(a:pos-1,0,-1)
	else | return -1
	endif
	let l:count = 0
	for l:i in l:range
		if a:string[l:i]==l:pair[l:base]
			if l:count==0 | return l:i | endif
			let l:count -= 1
		elseif a:string[l:i]==l:base
			let l:count += 1
		endif
	endfor
	return -1
endfunction

" Paranthesis Matcher: Find the position of matching '(' in a string.
function! <SID>matchparenpos1(string,pos)
	let [ l:count1, l:count2, ] = [ 0, 0 ]
	for l:i in range(a:pos+1,len(a:string)-1)
		if     a:string[l:i]=='[' | let l:count2 += 1
		elseif a:string[l:i]==']' | let l:count2 -= 1
		elseif a:string[l:i]=='(' | let l:count1 += 1
		elseif a:string[l:i]==')' && ( l:count2==0 )
			if l:count1==0 | return l:i | endif
			let l:count1-=1
		endif
	endfor
	return -1
endfunction

" Parser: Parse EmmeTex command to a list.
function! <SID>parse(string)
	if s:is_atom(a:string) | return [ a:string ] | endif
	if s:is_open_clam(a:string[0])
		let l:pos = <SID>matchparenpos1(a:string,0)
		return ['('] + <SID>parse(a:string[1:l:pos-1]) + [')']
					\ + ( l:pos==len(a:string)-1 ? [] : <SID>parse(a:string[l:pos+1:]) )
	endif
	for l:i in range(len(a:string))
		if s:is_optr(a:string[l:i])
			return ( l:i==0 ? [] : [a:string[:l:i-1]] ) + [a:string[l:i]] + <SID>parse(a:string[l:i+1:])
		elseif a:string[l:i]=~#'\([\|{\)'
			let l:pos = <SID>matchparenpos(a:string,l:i)
			return [a:string[:l:pos]] + ( l:pos==len(a:string)-1 ? [] : <SID>parse(a:string[l:pos+1:]) )
		endif
	endfor
endfunction

" Shunting Yeard: Convert EmmeTex infix notation to RPN.
function! <SID>shunting_yard(list)
	let l:output = []
	let l:stack  = [ '=' ]
	for l:item in a:list
		if s:is_opnd(l:item)
			let l:output += [ l:item ]
		elseif s:is_optr(l:item)
			if s:optr_prcdnt(l:item)==s:optr_prcdnt(l:stack[-1])
				let l:output += [ s:pop_list(l:stack) ]
				let l:stack  += [ l:item ]
			elseif s:optr_prcdnt(l:item)>s:optr_prcdnt(l:stack[-1])
				let l:stack += [ l:item ]
			else
				while s:optr_prcdnt(l:item)<s:optr_prcdnt(l:stack[-1])
					let l:output += [ s:pop_list(l:stack) ]
				endwhile
				let l:stack += [ l:item ]
			endif
		elseif s:is_open_clam(l:item)
			let l:stack += [l:item]
		elseif s:is_close_clam(l:item)
			while !s:is_open_clam(l:stack[-1])
				let l:output += [ s:pop_list(l:stack) ]
			endwhile
			let l:temp = s:pop_list(l:stack)
		else
			throw "Oops: Unexpected Item."
		endif
	endfor
	while len(l:stack)>1 | let l:output += [ s:pop_list(l:stack) ] | endwhile
	return l:output
endfunction

" Helper Function: Combining two operands with the operator.
" Operand Order: stack: [ ..., opnd1, opnd2 ].
function! <SID>expand_optr(opnd2,opnd1,optr)
	if s:is_plus_optr(a:optr)
		return a:opnd1 + a:opnd2
	elseif s:is_nest_optr(a:optr)
		let l:output = []
		for l:item in a:opnd1
			let l:output += s:is_marker(l:item) ? a:opnd2 : [ l:item ]
		endfor
		return l:output
	else
		throw "Oops: Unexpected Operator."
	endif
endfunction

" Helper Function: Expand operand.
function! <SID>expand_opnd(opnd)
	let l:body = s:opnd.body(a:opnd)
	let l:hask = has_key(g:emmetex_dict,l:body)
	let l:envr = { x -> l:hask ? g:emmetex_dict[x].env : x }( l:body )
	let l:nums = { x -> empty(x) ? 1 : str2nr(x) }( s:opnd.nums(a:opnd) )
	let l:opts = { x -> empty(x) ? ( l:hask ? g:emmetex_dict[l:body].opt : x ) : x }( s:opnd.opts(a:opnd) )
	if s:is_list(l:body)
		return [ '\begin{'.l:envr.'}'.l:opts ]
					\ + repeat( [ '\item', s:marker ], l:nums )
					\ + [ '\end{'.l:envr.'}' ]
	else
		return repeat( [ '\begin{'.l:envr.'}'.l:opts ]
					\ + ( l:hask ? g:emmetex_dict[l:body].ins : [] )
					\ + [ s:marker ]
					\ + [ '\end{'.l:envr.'}' ], l:nums )
	endif
endfunction

" Expand EmmeTex: Expand EmmeTex command string to list of output text.
function! emmetex#Expand(string)
	let l:stack = []
	let l:input = <SID>parse(a:string)-><SID>shunting_yard()
	for l:item in l:input
		if     s:is_opnd(l:item) | let l:stack+=[ <SID>expand_opnd(l:item) ]
		elseif s:is_optr(l:item) | let l:stack+=[ <SID>expand_optr(s:pop_list(l:stack),s:pop_list(l:stack),l:item) ]
		endif
	endfor
	return filter(l:stack[0],'!s:is_marker(v:val)')
endfunction

" Wrapper: Wrapper for emmetex#Expand().
function! emmetex#Emmet(string)
	try
		let l:output = emmetex#Expand(a:string)
		exe 'norm! i'.join(l:output,"\n")."\e=".( len(l:output)-1 ).'k$'
	catch
		echo "Oops: EmmeTex Syntax Error."
	endtry
endfunction
