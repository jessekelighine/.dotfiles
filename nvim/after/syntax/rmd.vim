" ~/.vim/after/syntax/rmd.vim

" syntax match   MarkdownListExpand "^\s*\(-\|+\|\*\|\d\{-}\.\|(\d.\{-})\)\s"
" syntax region  MarkdownComment    start="<!--" end="-->" contains=MarkdownTODO
" syntax region  TexMath            matchgroup=TexDollar start="\$"   end="\$"   contains=@NoSpell
" syntax region  TexMathEnv         matchgroup=TexDollar start="\$\$" end="\$\$" contains=@NoSpell
" syntax keyword MarkdownTODO       TODO

" highlight def link MarkdownListExpand Red
" highlight def link TexDollar          Grey
" highlight def link TexMath            String
" highlight def link TexMathEnv         String
" highlight def link MarkdownComment    Comment
" highlight def link MarkdownTODO       Todo
