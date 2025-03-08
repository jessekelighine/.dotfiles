" ~/.config/nvim/after/ftplugin/python.vim
" ~/.config/nvim/snippets/python/
" ~/.config/nvim/autoload/python.vim

command! -buffer -nargs=0 LastMod call my#LastMod('^\(#* *Last Modified: *\)[^ ]*', min([line("$"), 10]))
command! -buffer -nargs=0 -range=% Black silent <line1>,<line2> ! black --quiet -

" GENERAL SETTINGS: disables 8-wide tab, sensible listchars.
" let g:python_recommended_style = 0
" setlocal winminwidth=1
" setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 smarttab
" setl listchars=tab:┊\ ,trail:·,extends:»,precedes:«,nbsp:+

" FUNCTION KEYS:
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/python.vim<CR>
nnoremap <buffer> <leader>; <Cmd>call funcargs#DeleteFunction('[a-zA-Z_]','[a-zA-Z0-9_]')<CR>

" SNIPPETS:
inoremap <buffer> :bang<Tab> <Cmd>call my#GetSnippets('python', 'python_bang.py')<CR><Esc>
inoremap <buffer> :qui<Tab>  <Cmd>call my#GetSnippets('python', 'skeleton.py')<CR><Esc>
inoremap <buffer> :sign<Tab> <Cmd>call my#GetSnippets('python', 'sign.py')<CR><Esc>
inoremap <buffer> :bl<Tab>   <Cmd>call my#GetSnippets('python', 'block.py')<CR><Esc>

" IDE:
let b:python_command = "python"
let b:python_exit_command = repeat("\<C-C>", 5) .. repeat("\<C-D>", 5)
nnoremap <silent><buffer> <leader><Space> <Cmd>call vimslime#OpenTmux(b:python_command, "-D 5", b:python_exit_command)<CR>
nnoremap <silent><buffer> <leader>rf      <Cmd>call vimslime#OpenTmux(b:python_command, "-D 5", b:python_exit_command)<CR>
nnoremap <silent><buffer> <leader>rq      <Cmd>call vimslime#CloseTmux()<CR>
nnoremap <buffer><silent> <leader>rr      <Cmd>call vimslime#Send("\<C-l>")<CR>
nnoremap <buffer><silent> <leader>cc      <Cmd>call vimslime#Send("\<C-C>")<CR>
nnoremap <buffer><silent> <leader>d       m'"9yy  :call vimslime#Send(@9)<CR>`'
nnoremap <buffer><silent> <leader>rp      m'"9yiw :call vimslime#Send("print(" .. @9 .. ")", 1)<CR>`'
xnoremap <buffer><silent> <leader>rp      m'"9y   :call vimslime#Send("print(" .. @9 .. ")", 1)<CR>`'
xnoremap <buffer><silent> <leader>ss      m'"9y   :call vimslime#Send(@9, 1)<CR>`'
nnoremap <buffer><silent> <leader>pp      m'"9yip :call vimslime#Send(@9, 1)<CR>`'
nnoremap <buffer><silent> <leader>rG      m'"9yG  :call vimslime#Send(@9, 1)<CR>`'
