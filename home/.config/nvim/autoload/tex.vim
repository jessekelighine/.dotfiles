" ~/.config/nvim/autoload/tex.vim

" Print the line number (sub)sections.
function! tex#FindSection() abort
	let  [ l:index, l:section_lines, l:pos ] = [ 0, [], getpos('.') ]
	let  l:header_format = "%6s %6s  %s"
	let  l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^\\\(\(sub\)\{0,2}section\|\(sub\)\?paragraph\|chapter\|appendix\)/
				\ if match(getline("."), '^\\appendix') >= 0 | let l:display_name = "[Appendix]" |
				\ else | let @9 = @" | execute 'norm! yi{' | let l:section_name = @" | let @" = @9 |
				\ let l:display_name = match(getline("."), '^\\subparagraph')  >= 0 ? repeat(' ', 20) .. l:section_name
				\                    : match(getline("."), '^\\paragraph')     >= 0 ? repeat(' ', 16) .. l:section_name
				\                    : match(getline("."), '^\\subsubsection') >= 0 ? repeat(' ', 12) .. l:section_name
				\                    : match(getline("."), '^\\subsection')    >= 0 ? repeat(' ',  8) .. l:section_name
				\                    : match(getline("."), '^\\section')       >= 0 ? repeat(' ',  4) .. l:section_name
				\                    : match(getline("."), '^\\chapter')       >= 0 ? repeat(' ',  0) .. l:section_name : "ERROR" |
				\ endif |
				\ echo printf(l:header_format, line("."), l:index, l:display_name) |
				\ call add(l:section_lines, line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	exe l:index =~ '\d\+' ? "norm! " .. l:section_lines[l:index] .. "G" : "call setpos('.',l:pos)"
endfunction

" creates quote object in latex.
function! tex#Quotes(code, double) abort
	let l:begin = repeat("`", ( a:double ? 2 : 1 ))
	let l:end   = repeat("'", ( a:double ? 2 : 1 ))
	call search(l:begin, "bcW") | exec "norm " .. repeat('l', ( a:double ? 2 : 1 ))
	if a:code=="i"                                 | call search(l:end,  "sW") | exec "norm hv`'" | endif
	if a:code=="a" &&  a:double | exec "norm 2h"   | call search(l:end, "seW") | exec "norm v`'"  | endif
	if a:code=="q" &&  a:double | exec "norm hvhx" | call search(l:end, "seW") | exec "norm vh"   | endif
	if a:code=="a" && !a:double | exec "norm 1h"   | call search(l:end, "seW") | exec "norm v`'"  | endif
	if a:code=="q" && !a:double | exec "norm hvx"  | call search(l:end, "seW") | exec "norm v"    | endif
endfunction

" Delete parenthesis modifiers (left/right, big, large, ...).
function! tex#DelLeftRight() abort
	if getline(".")[col(".")-1] =~ '[()[\]{}]'
		silent execute 'norm hhvawohx%hhviwohx%'
	else
		let l:line = getline(".")
		let l:part_of_bar = l:line[col(".")-1] == '\' && l:line[col(".")] == '|'
		let l:bar_or_dot  = l:line[col(".")-1] =~ '[|.]'
		if  l:bar_or_dot || l:part_of_bar | execute "norm! hh" | endif
		execute "norm %%"
		let l:pos1 = getpos('.') | execute "norm %"
		let l:pos2 = getpos('.') | execute "norm %"
		let l:reversed_line = l:pos1[1] > l:pos2[1]
		let l:same_line_reversed_col = l:pos1[1] == l:pos2[1] && l:pos1[2] >= l:pos2[2]
		let l:reverse = l:reversed_line || l:same_line_reversed_col
		let l:pos_former = l:reverse ? l:pos2 : l:pos1
		let l:pos_latter = l:reverse ? l:pos1 : l:pos2
		call setpos(".", l:pos_latter) | execute "norm! de"
		call setpos(".", l:pos_former) | execute "norm! de"
		call setpos(".", l:pos1)
		" call search('\\\(left\|\(Big\|big\)l\?\)',  'cb') | exec 'norm de'
		" call search('\\\(right\|\(Big\|big\)r\?\)', '')   | exec 'norm de'
	endif
endfunction

""" SyncTeX """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" SyncTeX: Backwards setup
function! tex#ServerSetup() abort
	let l:tex_server_file = "~/.config/nvim/pack/lang/opt/tex/.tex-server"
	call system(join([ "echo", v:servername, ">", l:tex_server_file ]))
	echom " Server Saved: " .. v:servername
endfunction

" SyncTeX: Forwards function
function! tex#SkimForward() abort
	let l:utility = "/Applications/Skim.app/Contents/SharedSupport/displayline"
	let l:pdf_file = "'" .. expand("%:p:r") .. ".pdf" .. "'"
	let l:command = join([ l:utility, line('.'), l:pdf_file ])
	silent call system(l:command)
endfunction

""" Environments """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" replace the environment name on that line.
function! <SID>EnvironmentReplace(change)
	call execute('s/\V\\\(begin\|end\){\.\{-}}/\\\1{' .. a:change .. '}/')
endfunction

" get the environment name. Helper function for tex#EnvironmentStar().
function! <SID>EnvironmentGet()
	return matchstr(getline('.'), '^\s*\\\(begin\|end\){\zs.\{-}\ze}')
endfunction

" insert empty environment.
function! tex#EmptyEnvironment(name="", append="")
	let l:environment = a:name!="" ? a:name : input('Environment name: ')
	if  l:environment == '' | return | endif
	execute 'norm! A'..
				\ '\begin{' .. l:environment .. '}' .. a:append .. "\<CR>" ..
				\   '\end{' .. l:environment .. '}' ..
				\ "\<Esc>vk=_"
endfunction

" change a tex environment.
function! tex#EnvironmentChange(to='')
	let l:to = a:to=='' ? input('--> Environment Name: ') : a:to
	if  l:to=='' | return | endif
	let l:pos = getpos('.') | exec 'norm _%'
	call <SID>EnvironmentReplace(l:to) | call setpos('.', l:pos)
	call <SID>EnvironmentReplace(l:to) | call setpos('.', l:pos)
endfunction

" toggle star of a tex environment.
function! tex#EnvironmentStar()
	let l:en = <SID>EnvironmentGet()
	let l:to = strpart(l:en, strlen(l:en)-1)=='*' ? strpart(l:en, 0, strlen(l:en)-1) : l:en .. '*'
	call tex#EnvironmentChange(l:to)
endfunction

" delete the environment surrounding.
function! tex#EnvironmentDelete()
	let l:pos1 = getpos('.') | norm _%
	let l:pos2 = getpos('.')
	let l:pos  = l:pos1
	if l:pos1[1] > l:pos2[1] | let [l:pos1,l:pos2] = [l:pos2,l:pos1] | endif
	call setpos('.', l:pos2) | delete
	call setpos('.', l:pos1) | delete
	let l:pos2[1] = l:pos2[1] - 2
	exec "norm \<S-V>" .. ( l:pos2[1] - l:pos1[1] ) .. 'j='
	call setpos('.', l:pos)
endfunction
