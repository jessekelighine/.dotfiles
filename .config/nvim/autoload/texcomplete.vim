" ~/.config/nvim/autoload/texcomplete.vim

if !exists("g:texcomplete_labsfiles") | let g:texcomplete_labsfiles = [expand("%")] | endif
if !exists("g:texcomplete_bibsfiles") | let g:texcomplete_bibsfiles = ["references.bib"] | endif
let s:sort = {
			\ 'word': { x,y -> x.word >#  y.word ? 1 : -1 },
			\ 'menu': { x,y -> x.menu ==# y.menu ? s:sort.word(x,y) : ( x.menu ># y.menu ? 1 : -1 ) },
			\ }

function! texcomplete#SetFiles(type,files)
	if     a:type=='labs' | let g:texcomplete_labsfiles = a:files
	elseif a:type=='bibs' | let g:texcomplete_bibsfiles = a:files
	endif
endfunction

function! texcomplete#Show(type)
	execute "call <SID>generate_" .. a:type .. "()"
	execute "let l:list = g:texcomplete_" .. a:type
	let l:max_menu = 0
	let l:max_word = 0
	for l:item in l:list
		let l:max_menu = max([ len(l:item["menu"]), l:max_menu ])
		let l:max_word = max([ len(l:item["word"]), l:max_word ])
	endfor
	let l:print_pattern =
				\ "%" .. ( len(len(l:list)) + 1 ) .. "d" ..
				\ "%" .. ( l:max_menu + 1 ) .. "s" .. " " ..
				\ "%s"
	let l:count = 1
	for l:item in l:list
		echo printf(l:print_pattern, l:count, l:item.menu, l:item.word)
		let l:count += 1
	endfor
endfunction

""" Labs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes the list `g:texcomplete_labs` for auto-complete.
function! <SID>generate_labs(files=g:texcomplete_labsfiles) abort
	let l:lab_pattern_detect  = '\\label{.\{-}}'
	let l:lab_pattern_extract = '\\label{\zs.\{-}\ze}'
	let l:labs = []
	for l:file in a:files
		for l:line in readfile(l:file)
			if matchstrpos(l:line, l:lab_pattern_detect)[1] < 0 | continue | endif
			let l:labs = l:labs + [{
						\ 'word': matchstr(l:line, l:lab_pattern_extract),
						\ 'menu': '[' .. l:file .. ']',
						\ }]
		endfor
	endfor
	let g:texcomplete_labs = sort(l:labs, s:sort.word)
endfunction

" Auto-complete for LaTeX labels.
function! texcomplete#Labs(findstart, base) abort
	if a:findstart
		let l:trigger_pattern = '\\[a-zA-Z]*ref{'
		let l:look_ahead_length = 20
		return matchstrpos(getline('.'),
					\ l:trigger_pattern,
					\ col('.') - l:look_ahead_length)[2]
	else
		call <SID>generate_labs()
		let l:suggestions = []
		for l:item in g:texcomplete_labs
			if l:item['word'] =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction

""" Bibs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes a completion list `g:texcomplete_bibs` for auto-complete.
function! <SID>generate_bibs(files=g:texcomplete_bibsfiles)
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
	let g:texcomplete_bibs = sort(l:bibs, s:sort.menu)
endfunction

" Auto-complete for items in `bib` files.
function! texcomplete#Bibs(findstart, base)
	if a:findstart
		let l:trigger_pattern = '\\[a-zA-Z]*cite{'
		let l:look_ahead_length = 20
		return matchstrpos(getline('.'),
					\ l:trigger_pattern,
					\ col('.') - l:look_ahead_length)[2]
	else
		call <SID>generate_bibs()
		let l:suggestions = []
		for l:item in g:texcomplete_bibs
			if l:item['word'] =~ '^' .. a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction
