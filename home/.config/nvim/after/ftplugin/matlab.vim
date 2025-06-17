" ~/.config/nvim/after/ftplugin/matlab.vim
" ~/.config/nvim/autoload/matlab.vim
" ~/.config/nvim/snippets/matlab/

set expandtab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(%* Last Modified: *\)[^ ]*',min([10,line("$")]))

" FUNCTION KEYS: compile.
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/matlab.vim<CR>
nnoremap <buffer> <F2> :tabnew ~/.config/nvim/after/syntax/matlab.vim<CR>

" SNIPPETS: shebang, template.
inoremap <buffer> :sign<Tab> <Esc>:call snippets#Get('matlab','matlab_sign.m')<CR>
inoremap <buffer> :qui<Tab>  <Esc>:call snippets#Get('matlab','matlab_sign.m')<CR>
inoremap <buffer> :bl<Tab>   <Esc>:call snippets#Get('matlab','matlab_block.m')<CR>

" MAPPSINGS: useful mappings.
inoremap <buffer> ^<Tab>    ^()<Left>
nnoremap <buffer> <leader>; :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9_]')<CR>

" visual select "a section".
xnoremap <buffer><silent> as :call matlab#GetSection('a')<CR>
onoremap <buffer><silent> as :call matlab#GetSection('a')<CR>
xnoremap <buffer><silent> is :call matlab#GetSection('i')<CR>
onoremap <buffer><silent> is :call matlab#GetSection('i')<CR>

" IDE
let b:matlab_command = "matlab"
let b:matlab_exit_command = "exit;\r\n\<C-D>"
nnoremap <silent><buffer> <leader><Space> <Cmd>call vimslime#OpenTmux(b:matlab_command, '-D 5', b:matlab_exit_command)<CR>
nnoremap <silent><buffer> <leader>rf      <Cmd>call vimslime#OpenTmux(b:matlab_command, '-D 5', b:matlab_exit_command)<CR>
nnoremap <silent><buffer> <leader>rq      <Cmd>call vimslime#CloseTmux(b:matlab_exit_command)<CR>
xnoremap <buffer><silent> <leader>cc      <Cmd>call vimslime#Send("\<C-C>")<CR>
nnoremap <buffer><silent> <leader>ro      <Cmd>call vimslime#Send("who", 1)<CR>
nnoremap <buffer><silent> <leader>rr      <Cmd>call vimslime#Send("clc", 1)<CR>
nnoremap <buffer><silent> <leader>d       <Cmd>call vimslime#Forward("line")<CR>
nnoremap <buffer><silent> <leader>rp      <Cmd>call vimslime#Forward("word")<CR>
nnoremap <buffer><silent> <leader>rG      <Cmd>call vimslime#Forward("end")<CR>
nnoremap <buffer><silent> <leader>pp      <Cmd>call vimslime#Forward("paragraph")<CR>
xnoremap <buffer><silent> <leader>ss      <Cmd>call vimslime#Forward("selection")<CR>
xnoremap <buffer><silent> <leader>rp      <Cmd>call vimslime#Forward("selection")<CR>
nnoremap <buffer><silent> <leader>rh      <Cmd>call vimslime#Forward("word", 1, { x -> "help " .. x })<CR>
nnoremap <buffer><silent> <leader>rs      <Cmd>call vimslime#Forward("word", 1, { x -> "size(" .. x .. ")" })<CR>
xnoremap <buffer><silent> <leader>rs      <Cmd>call vimslime#Forward("selection", 1, { x -> "size(" .. x .. ")" })<CR>
nnoremap <buffer><silent> <leader>ss      m':call matlab#GetSection('i')<CR>"9y:call vimslime#Send(@9)<CR>`'
