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

let s:mode_map = {
			\ 'R':       { 'color': '%6*', 'text': 'REPLCE' },
			\ 'n':       { 'color': '%4*', 'text': 'NORMAL' },
			\ 's':       { 'color': '%7*', 'text': 'SELECT' },
			\ 'v':       { 'color': '%3*', 'text': 'VISUAL' },
			\ "\<C-V>":  { 'color': '%3*', 'text': 'V:BLOC' },
			\ 'V':       { 'color': '%3*', 'text': 'V:LINE' },
			\ 'i':       { 'color': '%2*', 'text': 'INSERT' },
			\ 'c':       { 'color': '%1*', 'text': 'COMMND' },
			\ 'snippet': { 'color': '%5*', 'text': 'SNIPPT' },
			\ }

function! StatuslineModeColor() abort
	let l:mode = s:mode_map[mode()].color .. " " .. s:mode_map[mode()].text
	let l:snippet_mode = s:mode_map.snippet.color .. " " .. s:mode_map[mode()].text
	if !has("nvim") | return l:mode | endif
	lua vim.g.statusline_snippet_mode_active = vim.snippet.active()
	return g:statusline_snippet_mode_active ? l:snippet_mode : l:mode
endfunction

function! <SID>StatusLine() abort
	set noshowmode
	set statusline=
	set statusline+=%{%StatuslineModeColor()%}\ [%M]\ %8*\ %F\ %y\ %9*
	set statusline+=%=%(%c%V\ %{%'%'.len(line('$')).'l'%}/%L\ %3p%%\ %8*\ [%{&fileencoding}]\ %)
endfunction

function! <SID>Highlight(number, bg, fg, bold) abort
	let l:user = "User" .. a:number
	let l:bold = a:bold ? "cterm=bold gui=bold" : ""
	let l:fg = join(["ctermfg=" .. a:fg.a, "guifg=" .. a:fg.hex])
	let l:bg = join(["ctermbg=" .. a:bg.a, "guibg=" .. a:bg.hex])
	exe join(["highlight", l:user, l:fg, l:bg, l:bold])
endfunction

call <SID>Highlight("1", s:colors.red,    s:colors.black, 1) " Mode: Command
call <SID>Highlight("2", s:colors.gold,   s:colors.black, 1) " Mode: Insert
call <SID>Highlight("3", s:colors.green,  s:colors.black, 1) " Mode: Visual
call <SID>Highlight("4", s:colors.white,  s:colors.black, 1) " Mode: Normal
call <SID>Highlight("5", s:colors.purple, s:colors.black, 1) " Mode: Snippet
call <SID>Highlight("6", s:colors.orange, s:colors.black, 1) " Mode: Replace
call <SID>Highlight("7", s:colors.blue,   s:colors.black, 1) " Mode: Select
call <SID>Highlight("8", s:colors.gray,   s:colors.white, 0) " Background: Gray
call <SID>Highlight("9", s:colors.black,  s:colors.white, 0) " Background: Black
call <SID>StatusLine()

command! -nargs=0 StatuslineReload call <SID>StatusLine()
nnoremap <silent> <CR> :StatuslineReload<CR>:nohlsearch<CR>:echo ""<CR>

augroup StatusLineReload
	autocmd!
	autocmd BufWritePost * StatuslineReload
augroup END
