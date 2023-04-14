" after/plugin/statusline.vim

let s:c = {
			\ 'red': { '2': 167, 'h': '#E68183' },
			\ 'ora': { '2': 208, 'h': '#E39B7B' },
			\ 'gol': { '2': 214, 'h': '#D9BB80' },
			\ 'gre': { '2': 108, 'h': '#87AF87' },
			\ 'blu': { '2': 109, 'h': '#89BEBA' },
			\ 'pur': { '2': 175, 'h': '#D3A0BC' },
			\ 'whi': { '2': 223, 'h': '#E6D6AC' },
			\ 'gra': { '2': 237, 'h': '#242021' },
			\ 'bla': { '2': 235, 'h': '#2A2426' },
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

exe 'hi User1 ctermbg='.s:c.red.2.' guibg='.s:c.red.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User2 ctermbg='.s:c.ora.2.' guibg='.s:c.ora.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User3 ctermbg='.s:c.gol.2.' guibg='.s:c.gol.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User4 ctermbg='.s:c.gre.2.' guibg='.s:c.gre.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User5 ctermbg='.s:c.blu.2.' guibg='.s:c.blu.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User6 ctermbg='.s:c.pur.2.' guibg='.s:c.pur.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User7 ctermbg='.s:c.whi.2.' guibg='.s:c.whi.h.' ctermfg='.s:c.bla.2.' guifg='.s:c.bla.h.' cterm=bold gui=bold'
exe 'hi User8 ctermbg='.s:c.gra.2.' guibg='.s:c.gra.h.' ctermfg='.s:c.whi.2.' guifg='.s:c.whi.h
exe 'hi User9 ctermbg='.s:c.bla.2.' guibg='.s:c.bla.h

set noshowmode
set statusline=
set statusline+=%{%g:statusline_change[mode()]%}\ [%M]\ %8*\ %F\ %y\ %9*
set statusline+=%=%(%c%V\ %{%'%'.len(line('$')).'l'%}/%L\ %3p%%\ %8*\ [%{&fileencoding}]\ %)
