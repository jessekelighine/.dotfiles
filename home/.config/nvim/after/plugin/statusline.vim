" ~/.config/nvim/after/plugin/statusline.vim

let s:colors = {
			\ 'red':    { 'a': 167, 'hex': '#E68183' },
			\ 'orange': { 'a': 208, 'hex': '#E39B7B' },
			\ 'gold':   { 'a': 214, 'hex': '#D9BB80' },
			\ 'green':  { 'a': 108, 'hex': '#87AF87' },
			\ 'blue':   { 'a': 109, 'hex': '#89BEBA' },
			\ 'purple': { 'a': 175, 'hex': '#D3A0BC' },
			\ 'white':  { 'a': 223, 'hex': '#E6D6AC' },
			\ 'gray':   { 'a': 237, 'hex': '#242021' },
			\ 'black':  { 'a': 235, 'hex': '#2A2426' },
			\ }

let g:statusline_mode_color_map = {
			\ 'n':      '%7*',
			\ "\<C-V>": '%6*',
			\ 's':      '%5*',
			\ 'v':      '%5*',
			\ 'V':      '%4*',
			\ 'i':      '%3*',
			\ 'R':      '%2*',
			\ 'c':      '%1*',
			\ }

function! <SID>Highlight(number, bg, fg, bold) abort
	let l:user = "User" .. a:number
	let l:bold = a:bold ? "cterm=bold gui=bold" : ""
	let l:fg = join(["ctermfg=" .. a:fg.a, "guifg=" .. a:fg.hex])
	let l:bg = join(["ctermbg=" .. a:bg.a, "guibg=" .. a:bg.hex])
	execute join(["highlight", l:user, l:fg, l:bg, l:bold])
endfunction

function! <SID>StatusLine() abort
    set noshowmode
    set statusline=
    set statusline+=%{%g:statusline_mode_color_map[mode()]%}\ [%M]\ %8*\ %F\ %y\ %9*
    set statusline+=%=%(%c%V\ %{%'%'.len(line('$')).'l'%}/%L\ %3p%%\ %8*\ [%{&fileencoding}]\ %)
endfunction

call <SID>Highlight("1", s:colors.red,    s:colors.black, 1)
call <SID>Highlight("2", s:colors.orange, s:colors.black, 1)
call <SID>Highlight("3", s:colors.gold,   s:colors.black, 1)
call <SID>Highlight("4", s:colors.green,  s:colors.black, 1)
call <SID>Highlight("5", s:colors.blue,   s:colors.black, 1)
call <SID>Highlight("6", s:colors.purple, s:colors.black, 1)
call <SID>Highlight("7", s:colors.white,  s:colors.black, 1)
call <SID>Highlight("8", s:colors.gray,   s:colors.white, 0)
call <SID>Highlight("9", s:colors.black,  s:colors.white, 0)
call <SID>StatusLine()

command! -nargs=0 StatuslineReload call <SID>StatusLine()
nnoremap <silent> <CR> :StatuslineReload<CR>:nohlsearch<CR>:echo ""<CR>

augroup StatusLineReload
	autocmd!
	autocmd BufWritePost * StatuslineReload
augroup END
