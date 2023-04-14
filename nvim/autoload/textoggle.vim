" ~/.config/nvim/autoload/textoggle.vim
" ~/.config/nvim/pack/lang/opt/tex

" toggle dictionary for textoggle#Master().
let g:textoggle_dict = {
			\ 'fig':    { 'display':'Figs & Tables', 'status':0, 'syntax':'figure.vim',    'plugin':''              },
			\ 'ref':    { 'display':'Refs & Cites',  'status':0, 'syntax':'refcite.vim',   'plugin':''              },
			\ 'notes':  { 'display':'Math Notes',    'status':0, 'syntax':'mathnotes.vim', 'plugin':'mathnotes.vim' },
			\ 'tex':    { 'display':'Plain Tex',     'status':0, 'syntax':'plain_tex.vim', 'plugin':''              },
			\ 'doc':    { 'display':'Document',      'status':0, 'syntax':'document.vim',  'plugin':''              },
			\ 'pre':    { 'display':'Preamble',      'status':0, 'syntax':'preamble.vim',  'plugin':''              },
			\ 'beamer': { 'display':'Beamer',        'status':0, 'syntax':'beamer.vim',    'plugin':'beamer.vim'    },
			\ 'tikz':   { 'display':'TikZ',          'status':0, 'syntax':'tikz.vim',      'plugin':'tikz.vim'      },
			\ }

" Reload the toggle dictionary. Helper function for textoggle#Reload().
function! <SID>ReloadToggleDict() abort
	let l:syntax = 'source ~/.config/nvim/pack/lang/opt/tex/syntax/'
	let l:plugin = 'source ~/.config/nvim/pack/lang/opt/tex/ftplugin/'
	for l:key in keys(g:textoggle_dict)
		if g:textoggle_dict[l:key]['status']
			if g:textoggle_dict[l:key]['syntax']!='' | exec l:syntax.g:textoggle_dict[l:key]['syntax'] | endif
			if g:textoggle_dict[l:key]['plugin']!='' | exec l:plugin.g:textoggle_dict[l:key]['plugin'] | endif
		endif
	endfor
endfunction

" Set key toggle status
function! textoggle#Set(key,status=1) abort
	let g:textoggle_dict[a:key]['status'] = a:status
endfunction

" Toggle key toggle status
function! textoggle#Toggle(key) abort
	call textoggle#Set(a:key,!g:textoggle_dict[a:key]['status'])
endfunction

" clear all toggles to default (no toggles, all zeros).
function! textoggle#Clear() abort
	for l:key in keys(g:textoggle_dict) | call textoggle#Set(l:key,0) | endfor
	call textoggle#Reload() | redraw | echom '--> All toggles cleared.'
endfunction

" print all the toggle status.
function! textoggle#Show() abort
	redraw
	for l:key in keys(g:textoggle_dict)
		let l:message = g:textoggle_dict[l:key]['status'] ? '+' : '-'
		echo printf("%2s%10s%15s",l:message,'['.l:key.']',g:textoggle_dict[l:key]['display'])
	endfor
endfunction

" toggle syntax/ftplygins.
function! textoggle#Master() abort
	call textoggle#Show()
	let l:key  = input('Toggle LaTeX Syntax: ') | if l:key==''             | return | endif
	let l:keys = keys(g:textoggle_dict)         | if index(l:keys,l:key)<0 | return | endif
	call textoggle#Toggle(l:key)
	call textoggle#Reload()
	redraw | echom '--> '.g:textoggle_dict[l:key]['display'].' syntax: '
				\ .( g:textoggle_dict[l:key]['status'] ? 'ON' : 'OFF' )
endfunction

" reload <buffer> key-mappings and toggles.
function! textoggle#Reload(local_vimrc=0) abort
	imapclear <buffer>
	nmapclear <buffer>
	omapclear <buffer>
	tmapclear <buffer>
	xmapclear <buffer>
	silent setlocal filetype=tex
	call <SID>ReloadToggleDict()
	if a:local_vimrc | call my#LocalVimrc() | endif
endfunction
