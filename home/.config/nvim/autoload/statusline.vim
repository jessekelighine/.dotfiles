" ~/.config/nvim/autoload/statusline.vim
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
			\ 'c':       { 'color': '%1*', 'text': 'COMMND' },
			\ 'R':       { 'color': '%2*', 'text': 'REPLCE' },
			\ 'r':       { 'color': '%2*', 'text': 'REPLCE' },
			\ 'i':       { 'color': '%3*', 'text': 'INSERT' },
			\ 'v':       { 'color': '%4*', 'text': 'VISUAL' },
			\ "\<C-V>":  { 'color': '%4*', 'text': 'V-BLCK' },
			\ 'V':       { 'color': '%4*', 'text': 'V-LINE' },
			\ 's':       { 'color': '%4*', 'text': 'SELECT' },
			\ 'snippet': { 'color': '%5*', 'text': 'SNIPPT' },
			\ 't':       { 'color': '%5*', 'text': 'TERMNL' },
			\ 'n':       { 'color': '%6*', 'text': 'NORMAL' },
			\ }

function! <SID>Highlight(number, bg, fg, bold) abort
	let l:user = "User" .. a:number
	let l:bold = a:bold ? "cterm=bold gui=bold" : ""
	let l:fg = join(["ctermfg=" .. a:fg.a, "guifg=" .. a:fg.hex])
	let l:bg = join(["ctermbg=" .. a:bg.a, "guibg=" .. a:bg.hex])
	exe join(["highlight", l:user, l:fg, l:bg, l:bold])
endfunction

function! <SID>DefineColors() abort
	call <SID>Highlight("1", s:colors.red,    s:colors.black, 1) " Mode: Command
	call <SID>Highlight("2", s:colors.orange, s:colors.black, 1) " Mode: Replace
	call <SID>Highlight("3", s:colors.gold,   s:colors.black, 1) " Mode: Insert
	call <SID>Highlight("4", s:colors.green,  s:colors.black, 1) " Mode: Visual
	call <SID>Highlight("5", s:colors.purple, s:colors.black, 1) " Mode: Snippet, Terminal
	call <SID>Highlight("6", s:colors.white,  s:colors.black, 1) " Mode: Normal
	call <SID>Highlight("7", s:colors.gray,   s:colors.gold,  1) " CWD
	call <SID>Highlight("8", s:colors.gray,   s:colors.white, 0) " Background: Gray
	call <SID>Highlight("9", s:colors.black,  s:colors.white, 0) " Background: Black
endfunction

function! <SID>SpecialFiletypePrefix() abort
	let l:special_filetypes = {
				\ "oil":      { "prefix": "oil://",  "is_this": &filetype == "oil"      },
				\ "terminal": { "prefix": "term://", "is_this": &buftype  == "terminal" },
				\ }
	for l:type in keys(l:special_filetypes)
		if l:special_filetypes[l:type].is_this
			return l:special_filetypes[l:type].prefix
		endif
	endfor
	return ""
endfunction

function! <SID>CWD() abort
	let l:cwd = getcwd()
	let l:cwd_length = strlen(l:cwd)
	let l:cwd_base = fnamemodify(l:cwd, ":t")
	let l:cwd_dir  = fnamemodify(l:cwd, ":h") == "/" ? "/" : fnamemodify(l:cwd, ":h") .. "/"
	let l:cwd_display = l:cwd_dir .. "%7*" .. l:cwd_base .. "%8*"
	if  l:cwd == "/"   | let l:cwd_display = "%7*" .. "/" .. "%8*" | endif
	if  l:cwd == $HOME | let l:cwd_display = "%7*" .. "~" .. "%8*" | endif
	let l:cwd_display = substitute(l:cwd_display, "^" .. $HOME, "~", "")
	" DETERMINE SPECIAL FILETYPES WITH PREFIXES:
	let l:prefix = <SID>SpecialFiletypePrefix()
	" FINAL FILE PATH DISPLAY:
	let l:file = substitute(expand("%:p"), "^" .. l:prefix,  "", "")->expand()
	if  l:file == "" | return l:cwd_display | endif
	if  l:file[0:(l:cwd_length - 1)] != l:cwd | return "%F" | endif
	return l:prefix .. l:cwd_display .. l:file[l:cwd_length:]
endfunction

function! statusline#Generate() abort
	" DETERMINE MODE:
	try   | lua vim.g.statusline_snippet_mode_active = vim.snippet.active()
	catch | let g:statusline_snippet_mode_active = v:false
	endtry
	let l:modified = &modifiable ? ( &modified ? "[+]" : "[ ]" ) : "[-]"
	let l:mode_regular = join([s:mode_map[mode()].color, s:mode_map[mode()].text, l:modified])
	let l:mode_snippet = join([s:mode_map.snippet.color, s:mode_map[mode()].text, l:modified])
	let l:mode = g:statusline_snippet_mode_active ? l:mode_snippet : l:mode_regular
	" LEFT-HAND SIDE:
	let l:empty_filetype = "[?]"
	let l:filetype = &filetype != "" ? "%y" : l:empty_filetype
	let l:lefthandside = join([l:mode, "%8*", <SID>CWD(), l:filetype, "%9*"])
	" RIGHT-HAND SIDE:
	let l:column_number = "%c%V"
	let l:line_number = "%{%'%' .. len(line('$')) .. 'l'%}/%L"
	let l:percentage = "%3p%%"
	let l:encoding = "[%{&fileencoding}]"
	let l:location_in_file = join([l:column_number, l:line_number, l:percentage])
	let l:righthandside = join([l:location_in_file, "%8*", l:encoding, ""])
	" COMBINE:
	return l:lefthandside .. "%=" .. l:righthandside
endfunction

function! statusline#Set() abort
	set noshowmode
	set statusline=%{%statusline#Generate()%}
endfunction

function! statusline#Setup() abort
	call <SID>DefineColors()
	call statusline#Set()
endfunction
