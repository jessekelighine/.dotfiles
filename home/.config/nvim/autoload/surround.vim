" ~/.config/nvim/autoload/surround.vim

let s:matchpairs = split(substitute(&matchpairs, ',\|:', "\<Space>", 'g'))
let s:matchpairs_dict = {
			\ '(': ['(', ')'],
			\ '{': ['{', '}'],
			\ '[': ['[', ']'],
			\ '1': ['（','）'],
			\ '2': ['「','」'],
			\ '3': ['『','』'],
			\ '4': ['《','》'],
			\ '5': ['【','】'],
			\ }

" Get the character at line and column, defaults the character under the cursor.
function! <SID>get_char(line=line('.'), col=col('.'))
	return matchstr(getline(a:line), '\%' .. a:col .. 'c.')
endfunction

" Test if a character is in "&matchpairs".
function! <SID>in_matchpairs(char=<SID>get_char())
	return index(s:matchpairs, a:char) >= 0
endfunction

" Add surrounding characters to a visually selected region.
function! surround#Add(key) range
	let [ l:start, l:end ] = [ getpos("'<"), getpos("'>") ]
	call setpos('.',l:end  ) | exec "norm! a" .. s:matchpairs_dict[a:key][0] .. "\e"
	call setpos('.',l:start) | exec "norm! i" .. s:matchpairs_dict[a:key][1] .. "\e"
endfunction

" Delete paired characters (in "matchpairs"). If "a:symbol" is given, then
" find the boundaries first. If "a:symbol" is not given and the current
" character is not in "matchpairs", do nothing.
" Testing: [ something( here ) { ... } ]
function! surround#Delete(symbol='')
	if !empty(a:symbol) | exec "norm! va".a:symbol."\e" | endif 
	if  empty(a:symbol) && !<SID>in_matchpairs() | return | endif 
	let [ l:l1, l:c1 ] = [ line("."), col(".") ] | norm! %
	let [ l:l2, l:c2 ] = [ line("."), col(".") ] | norm! %
	if  l:l1==l:l2 && l:c1>l:c2 | let [l:c1,l:c2] = [l:c2,l:c1] | endif
	call cursor(l:l2,l:c2) | norm! x
	call cursor(l:l1,l:c1) | norm! x
endfunction
