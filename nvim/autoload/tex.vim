" ~/.config/nvim/autoload/tex.vim

" Toggle Conceal Level
if !exists("g:tex_conceal_level") | let g:tex_conceal_level=0 | endif
function! tex#ConcealToggle() abort
	let g:tex_conceal_level = { 0:2, 2:3, 3:0 }[ g:tex_conceal_level ]
	execute "setlocal conceallevel=" .. g:tex_conceal_level
	echom " Conceal Level: " ..
				\ ( g:tex_conceal_level==0 ? "Original Text"
				\ : g:tex_conceal_level==1 ? "One Character"
				\ : g:tex_conceal_level==2 ? "Replacement Character"
				\ : g:tex_conceal_level==3 ? "Hide Completely"
				\ : "ERROR" )
endfunction

" Print the line number (sub)sections.
function! tex#FindSection() abort
	let  [ l:index, l:section_lines, l:pos ] = [ 0, [], getpos('.') ]
	let  l:header_format = "%6s %6s  %s"
	let  l:header = printf(l:header_format, "Line", "Index", "Title")
	echo l:header .. "\n" .. repeat("=", len(l:header))
	global/^\\\(sub\)*\(section\|paragraph\|chapter\)/
				\ execute 'norm! "9yi{' | let l:temp = @9 |
				\ let l:temp = match(getline("."),'^\\subparagraph')  >= 0 ? repeat(' ',20) .. l:temp
				\            : match(getline("."),'^\\paragraph')     >= 0 ? repeat(' ',16) .. l:temp
				\            : match(getline("."),'^\\subsubsection') >= 0 ? repeat(' ',12) .. l:temp
				\            : match(getline("."),'^\\subsection')    >= 0 ? repeat(' ', 8) .. l:temp
				\            : match(getline("."),'^\\section')       >= 0 ? repeat(' ', 4) .. l:temp
				\            : match(getline("."),'^\\chapter')       >= 0 ? repeat(' ', 0) .. l:temp : l:temp |
				\ echo printf(l:header_format, line("."), l:index, l:temp) |
				\ call add(l:section_lines,line(".")) |
				\ let l:index += 1
	let l:index = input("--> Go to: ")
	exe l:index =~ '\d\+' ? "norm! " .. l:section_lines[l:index] .. "G" : "call setpos('.',l:pos)"
endfunction

" Delete parenthesis modifiers (left/right, big, large, ...).
function! tex#DelLeftRight()
	if getline(".")[col(".")-1] =~ '['..'()'..'\[\]'..'{}'..']'
		silent execute 'norm hhvawohx%hhviwohx%'
	else
		call search('\\\(left\|Big\|big\)',  'cb', line(".")) | exec 'norm de'
		call search('\\\(right\|Big\|big\)', '',   line(".")) | exec 'norm de'
	endif
endfunction

function! tex#OpenTmux(command="") abort
	packadd! vim-slime
	if vimslime#Target()!="" || a:command=="" | call system("tmux resize-pane -Z") | return | endif
	" create new Tmux pane and set as target.
	let l:command =  'tmux split -c "$PWD";'
				\ .. 'tmux resize-pane -U 12;'
				\ .. "tmux list-panes -F '#{session_name}:#{window_index}.#{pane_index} #{pane_active}';"
				\ .. 'tmux last-pane;'
	let l:targets = system(l:command)->split('\n')->map('split(v:val," ")')
	for l:pane in l:targets | if l:pane[1]==1 | break | endif | endfor
	call vimslime#SetTarget(l:pane[0])
	" send LaTeX compilation command to Tmux pane.
	call vimslime#Send(a:command,1)
	" automatically close Tmux target when vim is closed
	augroup TexOpenTmux
		autocmd!
		autocmd VimLeave * exe vimslime#Target()=="" ? "" : 'call vimslime#Send("\<C-C>exit",1)'
	augroup END
endfunction

" insert empty environment.
function! tex#EmptyEnvironment(name="", append="")
	let l:environment = a:name!="" ? a:name : input('Environment name: ')
	if  l:environment == '' | return | endif
	exec 'norm! A'..
				\ '\begin{' .. l:environment .. '}' .. a:append .. "\<CR>" ..
				\   '\end{' .. l:environment .. '}' ..
				\ "\<Esc>vk="
endfunction

" creates quote object in latex.
function! tex#Quotes(code, double) abort
	let [ l:begin , l:end ] = [ repeat("`",(a:double?2:1)) , repeat("'",(a:double?2:1)) ]
	call search(l:begin,"bcW") | exec "norm " .. repeat('l',(a:double?2:1))
	if a:code=="i"                                 | call search(l:end, "sW") | exec "norm hv`'" | endif
	if a:code=="a" &&  a:double | exec "norm 2h"   | call search(l:end,"seW") | exec "norm v`'"  | endif
	if a:code=="q" &&  a:double | exec "norm hvhx" | call search(l:end,"seW") | exec "norm vh"   | endif
	if a:code=="a" && !a:double | exec "norm 1h"   | call search(l:end,"seW") | exec "norm v`'"  | endif
	if a:code=="q" && !a:double | exec "norm hvx"  | call search(l:end,"seW") | exec "norm v"    | endif
endfunction

" replace the environment name on that line.
function! <SID>EnvironmentReplace(change)
	call execute( 's/\V\\\(begin\|end\){\.\{-}}/\\\1{' . a:change . '}/' )
endfunction

" get the environment name. Helper function for tex#EnvironmentStar().
function! <SID>EnvironmentGet()
	return matchstr(getline('.'),'^\s*\\\(begin\|end\){\zs.\{-}\ze}')
endfunction

" change a tex environment.
function! tex#EnvironmentChange(to='')
	let l:to = a:to=='' ? input('Environment Name: ') : a:to
	if  l:to=='' | return | endif
	let l:pos = getpos('.') | exec 'norm _%'
	call <SID>EnvironmentReplace(l:to) | call setpos('.',l:pos)
	call <SID>EnvironmentReplace(l:to)
endfunction

" toggle star of a tex environment.
function! tex#EnvironmentStar()
	let l:en = <SID>EnvironmentGet()
	let l:to = strpart(l:en,strlen(l:en)-1)=='*' ? strpart(l:en,0,strlen(l:en)-1) : l:en.'*'
	call tex#EnvironmentChange(l:to)
endfunction

" delete the environment surrounding.
function! tex#EnvironmentDelete()
	let l:pos1 = getpos('.') | norm _%
	let l:pos2 = getpos('.')
	let l:pos  = l:pos1
	if l:pos1[1] > l:pos2[1] | let [l:pos1,l:pos2] = [l:pos2,l:pos1] | endif
	call setpos('.',l:pos2) | delete
	call setpos('.',l:pos1) | delete
	let l:pos2[1] = l:pos2[1] - 2
	exec "norm \<S-V>".( l:pos2[1] - l:pos1[1] ).'j='
	call setpos('.',l:pos)
endfunction
