" ~/.vim/after/syntax/tex/preamble.vim

syntax match TexPreambleFirst   "\\\<\(NeedsTeXFormat\|documentclass\|ProvidesPackage\)\>" contains=@NoSpell
syntax match TexPreambleCommand "\\\<\(usepackage\|newcommand\|renewcommand\)\>"           contains=@NoSpell
syntax match TexArguments       "#\d\>"

highlight TexPreambleFirst   ctermfg=208 cterm=bold guifg=#e39b7b gui=bold
highlight TexPreambleCommand ctermfg=108 cterm=bold guifg=#87af87 gui=bold
highlight TexArguments       ctermfg=214 guifg=#d9bb80
