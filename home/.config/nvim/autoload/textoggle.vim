" ~/.config/nvim/autoload/textoggle.vim
" ~/.config/nvim/pack/lang/opt/tex/
" ~/.local/share/nvim/lazy/vim-bunttex/

" toggle dictionary for textoggle#Master().
let g:textoggle_dict = {
			\ 'algorithm': { 'status':0, 'syntax':'algorithm.vim', 'plugin':''              },
			\ 'beamer':    { 'status':0, 'syntax':'',              'plugin':'beamer.vim'    },
			\ 'glossary':  { 'status':0, 'syntax':'glossary.vim',  'plugin':'glossary.vim'  },
			\ 'mathnotes': { 'status':0, 'syntax':'',              'plugin':'mathnotes.vim' },
			\ 'plaintex':  { 'status':0, 'syntax':'plaintex.vim',  'plugin':''              },
			\ 'tikz':      { 'status':0, 'syntax':'tikz.vim',      'plugin':'tikz.vim'      },
			\ }

" Unprotected Set Status
function! <SID>Set(key, status=1) abort
	let g:textoggle_dict[a:key]['status'] = a:status
endfunction

" Unprotected Get
function! <SID>Get(key, attribute) abort
	return g:textoggle_dict[a:key][a:attribute]
endfunction

"" Functions """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Clear all loaded <buffer> mappings
function! <SID>UnloadToggleDict() abort
	imapclear <buffer>
	nmapclear <buffer>
	omapclear <buffer>
	tmapclear <buffer>
	xmapclear <buffer>
	silent setlocal filetype=tex
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

" print all the toggle status.
function! <SID>Show() abort
	echo repeat(" ", 5) .. "P S"
	for l:key in keys(g:textoggle_dict)
		let l:active = <SID>Get(l:key, "status")
		let l:active_display = l:active ? "[+]" : "[ ]"
		let l:syntax_display = <SID>Get(l:key, "syntax")=="" ? " " : l:active ? "*" : "·"
		let l:plugin_display = <SID>Get(l:key, "plugin")=="" ? " " : l:active ? "*" : "·"
		echo join(["", l:active_display, l:plugin_display, l:syntax_display, l:key])
	endfor
endfunction

"" Commands """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Emphasize Environment Color
" command! -buffer -nargs=? EmphasizeEnvironment :call textoggle#EmphasizeEnvironment(<q-args>)
" function! textoggle#EmphasizeEnvironment(env="") abort
" 	if a:env == ""
" 		let l:env = input(" Emphasize Environment: ")
" 		if  l:env == "" | return | endif
" 	else
" 		let l:env = a:env
" 	endif
" 	execute join([
" 				\ 'syntax', 'match',
" 				\ 'TexEnvEmph',
" 				\ '/{\zs' .. l:env .. '\ze}/',
" 				\ 'containedin=TexEnvironment'
" 				\ ])
" endfunction

" Reset status of every toggle
function! textoggle#Begin() abort
	for l:key in keys(g:textoggle_dict)
		call <SID>Set(l:key, 0)
	endfor
	command -buffer -nargs=1 Load   call <SID>Set(<q-args>)
	command -buffer -nargs=1 Unload call <SID>Set(<q-args>, 0)
endfunction

" Unload then reload all toggles
function! textoggle#End() abort
	call <SID>UnloadToggleDict()
	call <SID>ReloadToggleDict()
	delcommand Load
	delcommand Unload
endfunction

" Reload Toggles
function! textoggle#Reload() abort
	call <SID>UnloadToggleDict()
	call <SID>ReloadToggleDict()
endfunction

" toggle syntax/ftplygins.
function! textoggle#Master() abort
	call <SID>Show()
	let l:key_pattern = input("--> Toggle: ")
	if  l:key_pattern == "" | return | endif
	let l:key = <SID>ExpandKey(l:key_pattern)
	if  l:key == "" | return | endif
	call <SID>Set(l:key, !<SID>Get(l:key, "status"))
	call textoggle#Reload()
	redraw | echom "--> Toggle: "
				\ .. l:key .. ": "
				\ .. ( <SID>Get(l:key, "status") ? "ON" : "OFF" )
endfunction
