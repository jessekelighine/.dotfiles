" after/plugin/statusline.vim

let s:c = {
			\ 'red':    { 'a': 167, 'b': '#E68183' },
			\ 'orange': { 'a': 208, 'b': '#E39B7B' },
			\ 'gold':   { 'a': 214, 'b': '#D9BB80' },
			\ 'green':  { 'a': 108, 'b': '#87AF87' },
			\ 'blue':   { 'a': 109, 'b': '#89BEBA' },
			\ 'purple': { 'a': 175, 'b': '#D3A0BC' },
			\ 'white':  { 'a': 223, 'b': '#E6D6AC' },
			\ 'gray':   { 'a': 237, 'b': '#242021' },
			\ 'black':  { 'a': 235, 'b': '#2A2426' },
			\ }

let g:statusline_change = {
			\ 'n'      : '%7*',
			\ "\<C-V>" : '%6*',
			\ 'v'      : '%5*',
			\ 'V'      : '%4*',
			\ 'i'      : '%3*',
			\ 'R'      : '%2*',
			\ 'c'      : '%1*',
			\ }

exe 'hi User1 ctermbg=' .. s:c.red.a    .. ' guibg=' .. s:c.red.b    .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User2 ctermbg=' .. s:c.orange.a .. ' guibg=' .. s:c.orange.b .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User3 ctermbg=' .. s:c.gold.a   .. ' guibg=' .. s:c.gold.b   .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User4 ctermbg=' .. s:c.green.a  .. ' guibg=' .. s:c.green.b  .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User5 ctermbg=' .. s:c.blue.a   .. ' guibg=' .. s:c.blue.b   .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User6 ctermbg=' .. s:c.purple.a .. ' guibg=' .. s:c.purple.b .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User7 ctermbg=' .. s:c.white.a  .. ' guibg=' .. s:c.white.b  .. ' ctermfg=' .. s:c.black.a .. ' guifg=' .. s:c.black.b .. ' cterm=bold gui=bold'
exe 'hi User8 ctermbg=' .. s:c.gray.a   .. ' guibg=' .. s:c.gray.b   .. ' ctermfg=' .. s:c.white.a .. ' guifg=' .. s:c.white.b
exe 'hi User9 ctermbg=' .. s:c.black.a  .. ' guibg=' .. s:c.black.b

set noshowmode
set statusline=
set statusline+=%{%g:statusline_change[mode()]%}\ [%M]\ %8*\ %F\ %y\ %9*
set statusline+=%=%(%c%V\ %{%'%'.len(line('$')).'l'%}/%L\ %3p%%\ %8*\ [%{&fileencoding}]\ %)
