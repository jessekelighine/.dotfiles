" ~/.vim/after/syntax/tex/refcite.vim

syntax match TexSubRefExtra  "\\\(refeq\|refer\|figref\|tabref\|nameref\)\>"                   contains=@NoSpell
syntax match TexSubRefExtra  "\\\(href\|url\|href\|hyperref\|hyperlink\)\>"                    contains=@NoSpell
syntax match TexSubCiteExtra "\\\(parencite\|citelist\|textcite\|citefield\|citename\|footcite\|cite\)\>" contains=@NoSpell

highlight def link TexSubRefExtra  Orange
highlight def link TexSubCiteExtra Orange
