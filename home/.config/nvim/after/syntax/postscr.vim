" ~/.config/nvim/after/syntax/postscr.vim

finish

syntax match PostScriptTodo "%%%.*$"

highlight PostScriptTodo cterm=bold,italic ctermfg=Gray
