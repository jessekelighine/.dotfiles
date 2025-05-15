" ~/.config/nvim/after/ftplugin/stata.vim

setlocal commentstring=//\ %s

nmap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/stata.vim<CR>
inoremap <buffer> `<Tab> `'<Left>

" IDE
let b:stat_command = "stata"
let b:stat_exit_command = "clear\r\nexit\r\nexit\r\n\<C-D>\<C-D>\<C-D>"
nnoremap <silent><buffer> <leader><Space> <Cmd>call vimslime#OpenTmux(b:stat_command, '-D 5', b:stat_exit_command)<CR>
nnoremap <silent><buffer> <leader>rr      <Nop>
nnoremap <silent><buffer> <leader>rf      <Cmd>call vimslime#OpenTmux(b:stat_command, '-D 5', b:stat_exit_command)<CR>
nnoremap <silent><buffer> <leader>rq      <Cmd>call vimslime#CloseTmux(b:stat_exit_command)<CR>
xnoremap <buffer><silent> <leader>cc      <Cmd>call vimslime#Send("\<C-C>")<CR>
nnoremap <buffer><silent> <leader>d       <Cmd>call vimslime#Forward("line")<CR>
nnoremap <buffer><silent> <leader>rp      <Cmd>call vimslime#Forward("word")<CR>
nnoremap <buffer><silent> <leader>rG      <Cmd>call vimslime#Forward("end")<CR>
nnoremap <buffer><silent> <leader>pp      <Cmd>call vimslime#Forward("paragraph")<CR>
xnoremap <buffer><silent> <leader>ss      <Cmd>call vimslime#Forward("selection")<CR>
xnoremap <buffer><silent> <leader>rp      <Cmd>call vimslime#Forward("selection")<CR>
nnoremap <buffer><silent> <leader>rh      <Cmd>call vimslime#Forward("word", 1, { x -> "help " .. x })<CR>
nnoremap <buffer><silent> <leader>rs      <Cmd>call vimslime#Forward("word", 1, { x -> "size(" .. x .. ")" })<CR>
xnoremap <buffer><silent> <leader>rs      <Cmd>call vimslime#Forward("selection", 1, { x -> "size(" .. x .. ")" })<CR>
