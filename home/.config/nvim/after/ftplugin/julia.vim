" ~/.config/nvim/ftplugin/julia.vim
" ~/.config/nvim/ftplugin/julia.lua
" ~/.config/nvim/lua/cmp/julia.lua
" ~/.config/nvim/autoload/julia.vim

" LASTMOD:
let b:lastmod_pattern = '^\(Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

" MACROS:
nnoremap <buffer><silent> <leader>;  <Cmd>call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9_]')<CR>

" PIPE:
inoremap <buffer><silent> <S-M><Tab> <Esc>:call julia#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call julia#PipeExpand('CR')<CR>

" IDE:
function! <SID>IDE() abort
	let b:julia_command = "julia"
	call vimslime#Open("" .. b:julia_command, "-l 15")
endfunction
command! -buffer -nargs=0 IDE call <SID>IDE()
nnoremap <silent><buffer> <leader><Space>  <Cmd>IDE<CR>
nnoremap <silent><buffer> <leader>rf       <Cmd>IDE<CR>
nnoremap <silent><buffer> <leader><CR>     <Cmd>call vimslime#Send("\n")<CR>
nnoremap <silent><buffer> <leader>rq       <Cmd>call vimslime#Close()<CR>
nnoremap <buffer><silent> <leader>rr       <Cmd>call vimslime#Send("\<C-l>")<CR>
nnoremap <buffer><silent> <leader>cc       <Cmd>call vimslime#Send("\<C-C>")<CR>
nnoremap <buffer><silent> <leader>d        <Cmd>call vimslime#Forward("line")<CR>
xnoremap <buffer><silent> <leader>d        <Cmd>call vimslime#Forward("selection")<CR>
xnoremap <buffer><silent> <leader>ss       <Cmd>call vimslime#Forward("selection")<CR>
nnoremap <buffer><silent> <leader>rp       <Cmd>call vimslime#Forward("word",      { "return": 1, "wrapper": { x -> "@show " .. x } })<CR>
xnoremap <buffer><silent> <leader>rp       <Cmd>call vimslime#Forward("selection", { "return": 1, "wrapper": { x -> "@show " .. x } })<CR>
nnoremap <buffer><silent> <leader>pp       <Cmd>call vimslime#Forward("paragraph")<CR>
nnoremap <buffer><silent> <leader>rt       <Cmd>call vimslime#Forward("word",      { "return": 1, "wrapper": { x -> "typeof(" .. x .. ")" } })<CR>
xnoremap <buffer><silent> <leader>rt       <Cmd>call vimslime#Forward("selection", { "return": 1, "wrapper": { x -> "typeof(" .. x .. ")" } })<CR>
nnoremap <buffer><silent> <leader>rs       <Cmd>call vimslime#Forward("word",      { "return": 1, "wrapper": { x -> "size(" .. x .. ")" } })<CR>
xnoremap <buffer><silent> <leader>rs       <Cmd>call vimslime#Forward("selection", { "return": 1, "wrapper": { x -> "size(" .. x .. ")" } })<CR>
nnoremap <buffer><silent> <leader>rl       <Cmd>call vimslime#Forward("word",      { "return": 1, "wrapper": { x -> "length(" .. x .. ")" } })<CR>
xnoremap <buffer><silent> <leader>rl       <Cmd>call vimslime#Forward("selection", { "return": 1, "wrapper": { x -> "length(" .. x .. ")" } })<CR>
