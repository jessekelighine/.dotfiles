" ~/.config/nvim/autoload/texcomplete.vim

let g:texcomplete_labsfiles = @%
let g:texcomplete_bibsfiles = substitute(@%,'\.tex$','.bib','g')
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
	let l:count = 1
	for l:item in ( a:type=='labs' ? g:texcomplete_labs : g:texcomplete_bibs )
		ech l:count."\t".l:item['menu']."\t".l:item['word']
		let l:count = l:count + 1
	endfor
endfunction

" Makes the list `g:texcomplete_labs` for auto-complete.
function! texcomplete#GenerateLabs(files=g:texcomplete_labsfiles) abort
	let l:labs = []
	for l:file in split(a:files)
		for l:l in readfile(l:file)
			if matchstrpos(l:l,'\\label{.\{-}}')[1]<0 | continue | endif
			let l:labs = l:labs + [{
						\ 'word': matchstr(l:l,'\\label{\zs.\{-}\ze}'),
						\ 'menu': '['.l:file.']',
						\ }]
		endfor
	endfor
	let g:texcomplete_labs = sort( l:labs, s:sort.word )
endfunction

" Auto-complete for LaTeX labels.
function! texcomplete#Labs(findstart,base) abort
	if a:findstart | return matchstrpos(getline('.'),'.*{')[2]
	else
		let l:suggestions = []
		cal texcomplete#GenerateLabs()
		for l:item in g:texcomplete_labs
			if l:item['word']=~'^'..a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction

" Makes a completion list `g:texcomplete_bibs` for auto-complete.
function! texcomplete#GenerateBibs(files=g:texcomplete_bibsfiles)
	let l:bibs = []
	for l:file in split(a:files)
		for l:l in readfile(l:file)
			if matchstrpos(l:l,'^@[a-zA-Z]\{-}{')[1]<0 | continue | endif
			let l:bibs = l:bibs + [{
						\ 'word': matchstr(l:l,'^@[a-z]\{-}{\zs.\{-}\ze,'),
						\ 'menu': '['.matchstr(l:l,'^@\zs[a-z]\{-}\ze{.\{-},').']',
						\ }]
		endfor
	endfor
	let g:texcomplete_bibs = sort( l:bibs, s:sort.menu )
endfunction

" Auto-complete for items in `bib` files.
function! texcomplete#Bibs(findstart,base)
	if a:findstart | return matchstrpos(getline('.'),'.*\({\|,\)')[2]
	else
		let l:suggestions = []
		cal texcomplete#GenerateBibs()
		for l:item in g:texcomplete_bibs
			if l:item['word']=~'^'..a:base
				call add(l:suggestions, l:item)
			endif
		endfor
		return l:suggestions
	endif
endfunction
