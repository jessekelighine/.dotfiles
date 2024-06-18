" ~/.config/nvim/after/syntax/r.vim
" /usr/local/Cellar/neovim/0.8.3/share/nvim/runtime/syntax/r.vim

syntax match RDTSet ":="
syntax match RPrefix "`.\{-}`"
syntax match rType "\\"
syntax keyword rType Matrix
syntax match rOperator "::"

highlight def link RDTSet  Operator
highlight def link RPrefix Operator
" highlight def link rType Type
