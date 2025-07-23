" ~/.config/nvim/autoload/quarto_complete.vim

if !exists("g:quarto_complete_labsfiles") || empty(g:quarto_complete_labsfiles)
	let g:quarto_complete_labsfiles = [expand("%")]
endif

if !exists("g:quarto_complete_bibsfiles") || empty(g:quarto_complete_bibsfiles)
	let g:quarto_complete_bibsfiles = ["references.bib"]
endif

let s:sort = {
			\ 'word': { x,y -> x.word >#  y.word ? 1 : -1 },
			\ 'menu': { x,y -> x.menu ==# y.menu ? s:sort.word(x,y) : ( x.menu ># y.menu ? 1 : -1 ) },
			\ }

function! quarto_complete#SetFiles(type,files)
	if     a:type == 'labs' | let g:quarto_complete_labsfiles = a:files
	elseif a:type == 'bibs' | let g:quarto_complete_bibsfiles = a:files
	endif
endfunction

function! quarto_complete#Show(type)
	let l:list = a:type =~ "labs" ? <SID>generate_labs() : <SID>generate_bibs()
	let l:max_menu = map(copy(l:list), { key,val -> len(val.menu) })->max()
	let l:printf_format = join([
				\ "%" .. ( len(len(l:list)) + 1 ) .. "d",
				\ "%" .. ( l:max_menu ) .. "s",
				\ "%s"
				\ ])
	for l:index in range(len(l:list))
		let l:menu = l:list[l:index].menu
		let l:word = l:list[l:index].word
		echo printf(l:printf_format, l:index, l:menu, l:word)
	endfor
endfunction

""" Labs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! <SID>generate_labs(files=g:quarto_complete_labsfiles) abort
	let l:lab_pattern_detect  = '{#[a-zA-Z0-9-_:]*'
	let l:lab_pattern_extract = '{#\zs[a-zA-Z0-9-_:]*\ze'
	let l:lab_pattern_extract_type = '{#\zs[a-zA-Z]*\ze'
	let l:labs = []
	for l:file in a:files
		for l:line in readfile(l:file)
			if matchstrpos(l:line, l:lab_pattern_detect)[1] < 0
				continue
			endif
			let l:word = matchstr(l:line, l:lab_pattern_extract)
			let l:type = matchstr(l:line, l:lab_pattern_extract_type)
			let l:menu = "(" .. l:type .. ") [" .. l:file .. "]"
			let l:labs = l:labs + [{ 'word': l:word, 'menu': l:menu }]
		endfor
	endfor
	return sort(l:labs, s:sort.word)
endfunction

function! quarto_complete#Labs(findstart, base) abort
	if a:findstart
		let l:trigger_pattern = '@'
		let l:look_ahead_length = 20
		let l:start_column = col('.') - l:look_ahead_length
		return matchstrpos(getline('.'), l:trigger_pattern, l:start_column)[2]
	else
		let l:all_labs = <SID>generate_labs()
		let l:suggestions = []
		for l:item in l:all_labs
			if l:item.word =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction

""" Bibs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! <SID>generate_bibs(files=g:quarto_complete_bibsfiles)
	let l:bib_pattern_detect  = '^@[a-zA-Z]\{-}{'
	let l:bib_pattern_extract = '^@[a-zA-Z]\{-}{\zs.\{-}\ze,'
	let l:bib_pattern_extract_type = '^@\zs[a-zA-Z]\{-}\ze{'
	let l:bibs = []
	for l:file in a:files
		for l:line in readfile(l:file)
			if matchstrpos(l:line, l:bib_pattern_detect)[1] < 0
				continue
			endif
			let l:word = matchstr(l:line, l:bib_pattern_extract)
			let l:type = matchstr(l:line, l:bib_pattern_extract_type)
			let l:menu = '[' .. l:type .. ']'
			let l:bibs = l:bibs + [{ 'word': l:word, 'menu': l:menu }]
		endfor
	endfor
	return sort(l:bibs, s:sort.menu)
endfunction

function! quarto_complete#Bibs(findstart, base)
	if a:findstart
		let l:trigger_pattern = '@'
		let l:look_ahead_length = 20
		let l:start_column = col('.') - l:look_ahead_length
		return matchstrpos(getline('.'), l:trigger_pattern, l:start_column)[2]
	else
		let l:all_bibs = <SID>generate_bibs()
		let l:suggestions = []
		for l:item in l:all_bibs
			if l:item.word =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction
