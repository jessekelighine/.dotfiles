" ~/.vim/after/syntax/tex/tex.vim

syntax match TexSubCommand "\\[a-zA-Z]*@[a-zA-Z@]*" contains=@NoSpell
syntax match TexSubCommand "\\[a-zA-Z]*_[a-zA-Z_]*" contains=@NoSpell
syntax match TexSubCommand "\\\(makeatletter\|makeatother\)" contains=@NoSpell

highlight def link TexSubCommand Yellow
