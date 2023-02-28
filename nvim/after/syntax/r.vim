" ~/.config/nvim/after/syntax/r.vim

syntax match RDTSet ":="
syntax match RPrefix "`.\{-}`"
syntax match rType "\\"
syntax keyword rType Matrix

highlight def link RDTSet  Operator
highlight def link RPrefix Operator
" highlight def link rType Type
