" ~/.config/nvim/autoload/tex.vim

" Print the line number (sub)sections.
function! tex#FindSection() abort
	let  [ l:index, l:section_lines, l:pos ] = [ 0, [], getpos('.') ]
	let  l:header_format = "%6s %6s  %s"
	let  l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^\\\(\(sub\)\{0,2}section\|\(sub\)\?paragraph\|chapter\|appendix\)/
				\ if match(getline("."), '^\\appendix') >= 0 |
				\     let l:display_name = "[Appendix]" |
				\ else |
				\     let @9 = @" |
				\     exe "norm! yi{" |
				\     let l:section_name = @" |
				\     let @" = @9 |
				\     let l:display_name = match(getline("."), '^\\subparagraph')  >= 0 ? repeat(' ', 20) .. l:section_name
				\                        : match(getline("."), '^\\paragraph')     >= 0 ? repeat(' ', 16) .. l:section_name
				\                        : match(getline("."), '^\\subsubsection') >= 0 ? repeat(' ', 12) .. l:section_name
				\                        : match(getline("."), '^\\subsection')    >= 0 ? repeat(' ',  8) .. l:section_name
				\                        : match(getline("."), '^\\section')       >= 0 ? repeat(' ',  4) .. l:section_name
				\                        : match(getline("."), '^\\chapter')       >= 0 ? repeat(' ',  0) .. l:section_name : "ERROR" |
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
		silent execute 'norm! hhvawohx%hhviwohx%'
	else
		let l:position = getpos(".")
		call search('\\\(left\|\(Big\|big\)l\?\)',  'cb') | exec 'norm de'
		call search('\\\(right\|\(Big\|big\)r\?\)', '')   | exec 'norm de'
		call setpos('.', l:position)
	endif
endfunction

""" SyncTeX """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" SyncTeX: Backwards setup
function! tex#ServerSetup() abort
	let g:tex_server_file = "~/.config/nvim/pack/lang/opt/tex/.tex-server"
	let l:command = join([ "echo", v:servername, ">", g:tex_server_file ])
	call system(l:command)
	echom " Server Saved: " .. v:servername
	augroup TeXRemoveServerFile
		autocmd!
		autocmd VimLeave * call system("rm -rf " .. g:tex_server_file)
	augroup END
endfunction

" SyncTeX: Forwards function
function! tex#SkimForward() abort
	let l:utility = "/Applications/Skim.app/Contents/SharedSupport/displayline"
	let l:pdf_file = "'" .. expand("%:p:r") .. ".pdf" .. "'"
	let l:command = join([ l:utility, line('.'), l:pdf_file ])
	silent call tex#ServerSetup()
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
	let l:env = a:name != "" ? a:name : input('--> Environment name: ')
	if l:env == '' | return | endif
	execute 'norm! A'..
				\ '\begin{' .. l:env .. '}' .. a:append .. "\<CR>" ..
				\   '\end{' .. l:env .. '}' ..
				\ "\<Esc>vk=_"
endfunction

" change a tex environment.
function! tex#EnvironmentChange(to='')
	let l:to = a:to != '' ? a:to : input('--> Environment Name: ')
	if l:to=='' | return | endif
	let l:position = getpos('.') | exec 'norm _%'
	call <SID>EnvironmentReplace(l:to) | call setpos('.', l:position)
	call <SID>EnvironmentReplace(l:to) | call setpos('.', l:position)
endfunction

" toggle star of a tex environment.
function! tex#EnvironmentStar()
	let l:env = <SID>EnvironmentGet()
	let l:last_char = strpart(l:env, strlen(l:env) - 1)
	let l:env_no_star = substitute(l:env, '\*$', '', 'g')
	let l:to = l:last_char == '*' ? l:env_no_star : l:env .. '*'
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
