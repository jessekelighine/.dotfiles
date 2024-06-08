" ~/.config/nvim/autoload/textoggle.vim
" ~/.config/nvim/pack/lang/opt/tex/
" ~/.local/share/nvim/lazy/vim-bunttex/

" toggle dictionary for textoggle#Master().
let g:textoggle_dict = {
			\ 'acronym':   { 'display':'Acronym',    'status':0, 'syntax':'acronym.vim',   'plugin':'acronym.vim'   },
			\ 'algorithm': { 'display':'Algorithm',  'status':0, 'syntax':'algorithm.vim', 'plugin':''              },
			\ 'beamer':    { 'display':'Beamer',     'status':0, 'syntax':'',              'plugin':'beamer.vim'    },
			\ 'notes':     { 'display':'Math Notes', 'status':0, 'syntax':'',              'plugin':'mathnotes.vim' },
			\ 'plaintex':  { 'display':'Plain Tex',  'status':0, 'syntax':'plaintex.vim',  'plugin':''              },
			\ 'tikz':      { 'display':'TikZ',       'status':0, 'syntax':'tikz.vim',      'plugin':'tikz.vim'      },
			\ }

" Unprotected Set Status
function! <SID>Set(key, status=1) abort
	let g:textoggle_dict[a:key]['status'] = a:status
endfunction

" Unprotected Get
function! <SID>Get(key, attribute) abort
	return g:textoggle_dict[a:key][a:attribute]
endfunction

" Reload the toggle dictionary
function! <SID>ReloadToggleDict() abort
	let l:syntax = 'source ~/.local/share/nvim/lazy/vim-bunttex/syntax-additional/'
	let l:plugin = 'source ~/.config/nvim/pack/lang/opt/tex/ftplugin/'
	for l:key in keys(g:textoggle_dict)
		if <SID>Get(l:key, "status")
			if <SID>Get(l:key, "syntax") != '' | exec l:syntax .. <SID>Get(l:key, "syntax") | endif
			if <SID>Get(l:key, "plugin") != '' | exec l:plugin .. <SID>Get(l:key, "plugin") | endif
		endif
	endfor
endfunction

" Expand Key Abbreviations
function! <SID>ExpandKey(key) abort
	for l:key in keys(g:textoggle_dict)
		if l:key =~# "^" .. a:key
			return l:key
		endif
	endfor
	return ''
endfunction

" Set key toggle status
function! textoggle#Set(key_pattern, status=1) abort
	let l:key = <SID>ExpandKey(a:key_pattern)
	if  l:key == '' | return | endif
	call <SID>Set(l:key, a:status)
endfunction

" clear all toggles to default (no toggles, all zeros).
function! textoggle#Clear() abort
	for l:key in keys(g:textoggle_dict)
		call <SID>Set(l:key, 0)
	endfor
	call textoggle#Reload()
	redraw | echom '--> All toggles cleared.'
endfunction

" print all the toggle status.
function! textoggle#Show() abort
	redraw
	let l:max_key = 1
	let l:max_dis = 1
	for l:key in keys(g:textoggle_dict)
		let l:max_key = { l -> l > l:max_key ? l : l:max_key }( len(l:key) + 3 )
		let l:max_dis = { l -> l > l:max_dis ? l : l:max_dis }( len(<SID>Get(l:key,"display")) + 1 )
	endfor
	for l:key in keys(g:textoggle_dict)
		let l:format = " " .. ( <SID>Get(l:key, "status") ? '(+)' : '(-)' )
					\ .. "%" .. l:max_key .. "s"
					\ .. "%" .. l:max_dis .. "s"
		echo printf(l:format, '[' .. l:key .. ']', <SID>Get(l:key, "display"))
	endfor
endfunction

" reload <buffer> key-mappings and toggles.
function! textoggle#Reload() abort
	imapclear <buffer>
	nmapclear <buffer>
	omapclear <buffer>
	tmapclear <buffer>
	xmapclear <buffer>
	silent setlocal filetype=tex
	call <SID>ReloadToggleDict()
endfunction

" toggle syntax/ftplygins.
function! textoggle#Master() abort
	call textoggle#Show()
	let l:key_pattern = input("--> Toggle LaTeX Syntax: ")
	if  l:key_pattern == "" | return | endif
	let l:key = <SID>ExpandKey(l:key_pattern)
	if  l:key == '' | return | endif
	call <SID>Set(l:key, !<SID>Get(l:key, "status"))
	call textoggle#Reload()
	redraw | echom "--> "
				\ ..   <SID>Get(l:key, "display") .. " syntax: "
				\ .. ( <SID>Get(l:key, "status") ? "ON" : "OFF" )
endfunction
