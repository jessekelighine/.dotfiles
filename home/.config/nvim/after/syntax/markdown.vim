" ~/.config/nvim/after/syntax/markdown.vim

" syntax keyword MarkdownTODO TODO
" syntax region  MarkdownComment start="<!--" end="-->" contains=MarkdownTODO
syntax match   markdownDiv /^:::.*$/
" syntax match   MarkdownListExpand "^\s*\(-\|+\|\*\|\d\{-}\.\|(\d.\{-})\)\s"

" highlight def link MarkdownComment    Comment
" highlight def link MarkdownTODO       Todo
highlight def link markdownDiv        Todo
" highlight def link MarkdownListExpand Red
