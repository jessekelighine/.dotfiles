" ~/.config/nvim/after/ftplugin/stata.vim

" SETTINGS:
setlocal commentstring=//\ %s

" STATA SYNTAX:
inoremap <buffer> `<Tab> `'<Left>

" IDE
let b:stat_command = "stata"
nnoremap <silent><buffer> <leader><Space> <Cmd>call vimslime#Open(b:stat_command, "-l 10")<CR>
nnoremap <silent><buffer> <leader>rr      <Nop>
nnoremap <silent><buffer> <leader>rf      <Cmd>call vimslime#Open(b:stat_command, "-l 10")<CR>
nnoremap <silent><buffer> <leader>rq      <Cmd>call vimslime#Close()<CR>
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
