" ~/.config/nvim/autoload/quarto_complete.vim

if !exists("g:quarto_complete_labsfiles") | let g:quarto_complete_labsfiles = [expand("%")] | endif
let s:sort = {
			\ 'word': { x,y -> x.word >#  y.word ? 1 : -1 },
			\ 'menu': { x,y -> x.menu ==# y.menu ? s:sort.word(x,y) : ( x.menu ># y.menu ? 1 : -1 ) },
			\ }

function! quarto_complete#SetFiles(type,files)
	if     a:type=='labs' | let g:quarto_complete_labsfiles = a:files
	elseif a:type=='bibs' | let g:quarto_complete_bibsfiles = a:files
	endif
endfunction

function! quarto_complete#Show(type)
	execute "call <SID>generate_" .. a:type .. "()"
	execute "let l:list = g:quarto_complete_" .. a:type
	let l:max_menu = map(copy(l:list), { key,val -> len(val.menu) })->max()
	let l:print_pattern = join([
				\ "%" .. ( len(len(l:list)) + 1 ) .. "d",
				\ "%" .. ( l:max_menu ) .. "s",
				\ "%s"
				\ ])
	for l:index in range(len(l:list))
		let l:menu = l:list[l:index].menu
		let l:word = l:list[l:index].word
		echo printf(l:print_pattern, l:index, l:menu, l:word)
	endfor
endfunction

""" Labs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes the list `g:quarto_complete_labs` for auto-complete.
function! <SID>generate_labs(files=g:quarto_complete_labsfiles) abort
	let l:lab_pattern_detect  = '{#[a-zA-Z0-9-_:]*'
	let l:lab_pattern_extract = '{#\zs[a-zA-Z0-9-_:]*\ze'
	let l:lab_pattern_extract_type = '{#\zs[a-zA-Z0-9]*\ze'
	let l:labs = []
	for l:file in a:files
		for l:line in readfile(l:file)
			if matchstrpos(l:line, l:lab_pattern_detect)[1] < 0 | continue | endif
			let l:labs = l:labs + [{
						\ 'word': matchstr(l:line, l:lab_pattern_extract),
						\ 'menu': "[" .. l:file .. "] (" .. matchstr(l:line, l:lab_pattern_extract_type) .. ") "
						\ }]
		endfor
	endfor
	let g:quarto_complete_labs = sort(l:labs, s:sort.word)
endfunction

" Auto-complete for labels.
function! quarto_complete#Labs(findstart, base) abort
	if a:findstart
		let l:trigger_pattern = '@'
		let l:look_ahead_length = 20
		return matchstrpos(getline('.'),
					\ l:trigger_pattern,
					\ col('.') - l:look_ahead_length)[2]
	else
		call <SID>generate_labs()
		let l:suggestions = []
		for l:item in g:quarto_complete_labs
			if l:item['word'] =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction

""" Bibs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes a completion list `g:quarto_complete_bibs` for auto-complete.
function! <SID>generate_bibs(files=g:quarto_complete_bibsfiles)
	let l:bib_pattern_detect  = '^@[a-zA-Z]\{-}{'
	let l:bib_pattern_extract = '^@[a-zA-Z]\{-}{\zs.\{-}\ze,'
	let l:bib_pattern_extract_menu = '^@\zs[a-zA-Z]\{-}\ze{'
	let l:bibs = []
	for l:file in a:files
		for l:line in readfile(l:file)
			if matchstrpos(l:line, l:bib_pattern_detect)[1] < 0 | continue | endif
			let l:bibs = l:bibs + [{
						\ 'word': matchstr(l:line, l:bib_pattern_extract),
						\ 'menu': '[' .. matchstr(l:line, l:bib_pattern_extract_menu) .. ']',
						\ }]
		endfor
	endfor
	let g:quarto_complete_bibs = sort(l:bibs, s:sort.menu)
endfunction

" Auto-complete for items in `bib` files.
function! quarto_complete#Bibs(findstart, base)
	if a:findstart
		let l:trigger_pattern = '@'
		let l:look_ahead_length = 20
		return matchstrpos(getline('.'),
					\ l:trigger_pattern,
					\ col('.') - l:look_ahead_length)[2]
	else
		call <SID>generate_bibs()
		let l:suggestions = []
		for l:item in g:quarto_complete_bibs
			if l:item['word'] =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction
