" ~/.config/nvim/autoload/csv.vim

""" General Functions """""""""""""""""""""""""""""""""""""""""""""""""""""""""

" initialise csv: (1) detect delim; (2) count number of columns.
function! csv#InitializeCSV()
	silent! call csv#SetDelim()
	silent! call <SID>SetTotalColumnNumber()
endfunction

" Set the deliminator of the file.  If no input given, tries to guess the
" deliminator of the file.
function! csv#SetDelim(default='')
	if a:default!=''
		let b:csv_delim = a:default
	else
		try
			exec "norm /\t\<CR>"
			let b:csv_delim = "\t"
		catch
			let b:csv_delim = ','
		endtry
	endif
	execu "norm :noh\<CR>"
	echom "Deliminator = " .. b:csv_delim
endfunction

" Highlight a column in csv text.  Command `:HiCol <NUMBER>` highlights the
" `<NUMBER>`-th column.  Use `:HiCol 0` to remove the highlighting.
function! csv#HighlightColumn(colnr=-1, colnm='')
	let [l:colnr,l:colnm] = [a:colnr,a:colnm]
	let l:pos = getpos('.')
	if l:colnr == 0 | match
	else
		call <SID>SetColumn( l:colnr, l:colnm )
		exec 'match Keyword ' .. <SID>BuildSearchString('/','/')
	endif
	call setpos('.', l:pos)
	silent :noh | redraw | echom <SID>GetColumnInfo()
endfunction

" Go to the focused column and show information about the column.
function! csv#GoToColumn()
	silent exe 'norm 0' .. <SID>BuildSearchString('/',"\<CR>")
	redraw | echom <SID>GetColumnInfo()
endfunction

" Go to the next/previous column.
function! csv#PrevNextColumn(direction)
	let l:chars = "[^" .. b:csv_delim .. "]"
	if a:direction == "next"
		let l:pos = getpos('.')
		silent! execute "norm f" .. b:csv_delim
		if getpos('.') == l:pos | return | endif
		call search(l:chars,'',line('.'))
	elseif a:direction == "prev"
		call search(b:csv_delim, 'b', line('.'))
		call search(l:chars, 'b', line('.'))
		let  l:pos = getpos('.')
		call search(b:csv_delim, 'b', line('.'))
		exec "norm " .. ( getpos('.') == l:pos ? "_" : "l" )
	endif
endfunction

" Print Header
function! csv#FindColumn() abort
	let l:pos = getpos('.')
	echo " Nr.  Name"
	echo "==========="
	echo split(getline(1), b:csv_delim)->map(
				\ { key, val -> printf('% 3d', str2nr(key)+1) .. repeat(' ', 3) .. val }
				\ )->join("\n")
	let l:input = input("--> Highlight Column: ")
	if  l:input=~'\d\+'
		call csv#HighlightColumn(l:input)
		call csv#GoToColumn()
	else
		call setpos('.', l:pos)
	endif
endfunction

""" Search String Building """"""""""""""""""""""""""""""""""""""""""""""""""""

" Returns a search string for column b:csv_column.
" Sample String: \(""\|"\(\\\\\|\\"\|[^\\"]\)\+"\|[^,"]\{-}\)\s*,\s*
function! <SID>BuildSearchString(prepend="",append="")
	let l:chars   = '[^' .. b:csv_delim .. ']'
	let l:pattern = '^'
				\ .. '\(' .. l:chars .. '\{-}' .. b:csv_delim .. '\)'
				\ .. '\{' .. ( b:csv_column - 1 ) .. '}'
				\ .. '\zs' .. l:chars .. '\+' .. '\ze'
	return a:prepend .. l:pattern .. a:append
endfunction

""" Get/Set Column Numbers/Names """"""""""""""""""""""""""""""""""""""""""""""

" Return the number of column the cursor is on.
function! <SID>GetColumnNumber()
	let l:counting = 0
	silent exe 'norm v0o'
	try   | let l:counting = execute('s/\%V' .. b:csv_delim .. '//gn')
	catch | let l:counting = '0 match on 1 line'
	endtry
	silent exe "norm \<Esc>"
	return <SID>StripSearch(l:counting)+1
endfunction

" Return the name of column number `b:csv_column`.
function! <SID>GetColumnName(column=b:csv_column)
	let l:y_to_reg = '"' .. g:csv_register .. 'y'
	let l:search   = <SID>BuildSearchString('/',"\<CR>")
	let l:commands = "norm gg0" .. l:search .. ( a:column==1 ? "N" : "" ) .. "gn" .. l:y_to_reg
	silent exe l:commands
	silent exe 'return @' .. g:csv_register
endfunction

" set the focused column number and name.
function! <SID>SetColumn(number=-1,name="")
	let b:csv_column      = a:number == -1 ? <SID>GetColumnNumber() : a:number
	let b:csv_column_name = a:name   == "" ? <SID>GetColumnName()   : a:name
endfunction

" Set `b:csv_total_column_number` to the total number of column numbers. Does
" not retun anything.
function! <SID>SetTotalColumnNumber()
	let l:count_output = execute('1,1s/' .. b:csv_delim .. '//gn')
	let l:count = <SID>StripSearch(l:count_output) + 1
	let b:csv_total_column_number = l:count
	silent norm :noh
endfunction

" Returns information about the focused column.
function! <SID>GetColumnInfo(number=b:csv_column, name=b:csv_column_name, delim=b:csv_delim)
	return ' Column ' .. a:number ..
				\ ' [' .. a:name .. ']' ..
				\ ' of ' .. b:csv_total_column_number ..
				\ ' ( Deliminator = ' .. a:delim .. ' )'
endfunction

""" Helper Functions """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns number of matches from search result.
" E.g., input "10 matches on 2 line" will return "10".
function! <SID>StripSearch(result)
	return trim(strpart(a:result, 0, stridx(a:result, " ")))
endfunction
