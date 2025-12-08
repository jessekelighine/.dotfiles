" ~/.config/nvim/after/ftplugin/python.vim
" ~/.config/nvim/after/ftplugin/python.lua
" ~/.config/nvim/lua/cmp/python.lua
" ~/.config/nvim/snippets/python/
" ~/.config/nvim/autoload/python.vim

command! -buffer -nargs=0 -range=% Black silent <line1>,<line2> ! black --quiet -

" LASTMOD:
let b:lastmod_pattern = '^\(#* *Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

" GENERAL SETTINGS: disables 8-wide tab, sensible listchars.
" let g:python_recommended_style = 0
" setlocal winminwidth=1
" setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 smarttab
" setl listchars=tab:┊\ ,trail:·,extends:»,precedes:«,nbsp:+

" FUNCTION ARGS:
nnoremap <buffer> <leader>; <Cmd>call funcargs#DeleteFunction('[a-zA-Z_]','[a-zA-Z0-9_.]')<CR>

" IDE:
function! <SID>Forward(type) abort
	let l:types = {
				\ "paragraph": { "pre": "",   "yank": "yip" },
				\ "selection": { "pre": "gv", "yank": "y"   },
				\ }
	silent exec "norm! \<Esc>"
	silent exec "norm! m'" .. l:types[a:type].pre .. '"9' .. l:types[a:type].yank
	let l:lines = split(@9, "\n")
	let l:filtered_lines = filter(l:lines, { key, val -> val =~# '\S' }) " Remove empty lines
	let l:filtered_text = join(l:filtered_lines, "\n") .. "\n"
	let l:last_line = l:filtered_lines[-1]
	let l:last_line_is_indented = l:last_line =~ '^\s\+'
	let l:return = l:last_line_is_indented
	silent call vimslime#Send(l:filtered_text, l:return)
	silent exec "norm! `'"
endfunction
function! <SID>IDE() abort
	let b:python_command = "ipython --no-autoindent"
	call vimslime#Open("\<C-C>" .. b:python_command, "-l 15")
endfunction
command! -buffer -nargs=0 IDE call <SID>IDE()
nnoremap <silent><buffer> <leader><Space>  <Cmd>IDE<CR>
nnoremap <silent><buffer> <leader>rf       <Cmd>IDE<CR>
nnoremap <silent><buffer> <leader>rq       <Cmd>call vimslime#Close()<CR>
nnoremap <silent><buffer> <leader><CR>     <Cmd>call vimslime#Send("\n")<CR>
nnoremap <buffer><silent> <leader>rr       <Cmd>call vimslime#Send("\<C-l>")<CR>
nnoremap <buffer><silent> <leader>cc       <Cmd>call vimslime#Send("\<C-C>")<CR>
nnoremap <buffer><silent> <leader>d        <Cmd>call vimslime#Forward("line")<CR>
xnoremap <buffer><silent> <leader>d        <Cmd>call <SID>Forward("selection")<CR>
xnoremap <buffer><silent> <leader>ss       <Cmd>call <SID>Forward("selection")<CR>
xnoremap <buffer><silent> <leader>rp       <Cmd>call <SID>Forward("selection")<CR>
nnoremap <buffer><silent> <leader>pp       <Cmd>call <SID>Forward("paragraph")<CR>
nnoremap <buffer><silent> <leader>rp       <Cmd>call vimslime#Forward("word", { "return": 1 })<CR>
nnoremap <buffer><silent> <leader>rt       <Cmd>call vimslime#Forward("word", { "return": 1, "wrapper": { x -> "type(" .. x .. ")" } })<CR>
