" hilite.vim

"### Helper Function ##########################################################

" helper function for hilite#Hilite(): highlight the area defined by the input
" list and add the id to global dictionary.
function! <SID>Add(list,group='Hilite')
	let l:temp = matchaddpos(a:group,a:list)
	let g:hilite_matchaddpos_ids = g:hilite_matchaddpos_ids + [ l:temp ]
endfunction

"### Three Visual Modes #######################################################

" helper function for hilite#Hilite(): highlight "Visual Mode".
function! <SID>VisualMode(begin,end)
	let [ l:begin_line, l:begin_col ] = [ a:begin[1], a:begin[2] ]
	let [ l:end_line,   l:end_col   ] = [ a:end[1],   a:end[2]   ]
	if l:begin_line==l:end_line
		call <SID>Add([ [l:begin_line, l:begin_col, l:end_col-l:begin_col+1] ])
	else
		call <SID>Add([ [l:begin_line, l:begin_col, len(getline('.'))] ])
		let l:begin_line = l:begin_line + 1
		while l:begin_line != l:end_line
			call <SID>Add([ [l:begin_line] ])
			let l:begin_line = l:begin_line + 1
		endwhile
		call <SID>Add([ [l:begin_line, 1, l:end_col] ])
	endif
endfunction

" helper function for hilite#Hilite(): highlight "Visual Line Mode".
function! <SID>VisualLineMode(begin,end)
	let [ l:begin_line, l:end_line ] = [ a:begin[1], a:end[1] ]
	while l:begin_line != l:end_line
		call <SID>Add([[l:begin_line]])
		let l:begin_line = l:begin_line + 1
	endwhile
	call <SID>Add([l:begin_line])
endfunction

" helper function for hilite#Hilite(): highlight "Visual Block Mode".
function! <SID>VisualBlockMode(begin,end)
	let [ l:begin_line, l:begin_col ] = [ a:begin[1], a:begin[2] ]
	let [ l:end_line,   l:end_col   ] = [ a:end[1],   a:end[2]   ]
	while l:begin_line != l:end_line
		call <SID>Add([ [l:begin_line, l:begin_col, l:end_col-l:begin_col+1] ])
		let l:begin_line = l:begin_line + 1
	endwhile
	call <SID>Add([ [l:begin_line, l:begin_col, l:end_col-l:begin_col+1] ])
endfunction

"### Main Functions ###########################################################

" main function.
function! hilite#Hilite() range
	let l:mode = visualmode()
	let [ l:begin, l:end ] = [ getpos("'<"), getpos("'>") ]
	if     l:mode=="v"      | call <SID>VisualMode(l:begin,l:end)
	elseif l:mode=="V"      | call <SID>VisualLineMode(l:begin,l:end)
	elseif l:mode=="\<C-V>" | call <SID>VisualBlockMode(l:begin,l:end)
	endif
	call setpos('.',l:end)
endfunction

" clear all the highlights.
function! hilite#Clear()
	for l:id in g:hilite_matchaddpos_ids | call matchdelete(l:id) | endfor
	let g:hilite_matchaddpos_ids = []
endfunction
