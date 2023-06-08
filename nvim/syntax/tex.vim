" ~/.config/nvim/syntax/tex.vim
" ~/.config/nvim/pack/lang/opt/tex/syntax

if exists("b:current_syntax") | finish | endif

syntax keyword TexTODO               TODO contained
syntax match   TexCommand            "\\\{1,2}"
syntax match   TexCommand            "\\[a-zA-Z]\+" contains=@NoSpell
syntax match   TexAnd                "&"
syntax match   TexBeginEnd           "\\\(begin\|end\)\>" contained
syntax match   TexTagItem            "\\\(item\|tag\)\>"
syntax match   TexSubRef             "\\\(label\|ref\|pageref\|eqref\)\>"            contains=@NoSpell
syntax match   TexSubRef             "\\\(refeq\|refer\|figref\|tabref\|nameref\)\>" contains=@NoSpell
syntax match   TexSubRef             "\\\(href\|url\|href\|hyperref\|hyperlink\)\>"  contains=@NoSpell
syntax match   TexSubCite            "\\\(parencite\|citelist\|textcite\|citefield\|citename\|footcite\|cite\)\>" contains=@NoSpell
syntax match   TexSubLR              "\\\(left\|right\|big\|Big\|middle\|Bigg\)\>" contains=@NoSpell
syntax match   TexSubFoot            "\\\(footnotemark\|footnote\)\>" contains=@NoSpell
syntax match   TexSection            "\\\(sub\)\{0,2}\(section\|paragraph\|chapter\)\>" contains=@NoSpell
syntax match   TexSection            "\\appendix\>"
syntax match   TexComment            "%.*"  contains=@NoSpell,TexTODO
syntax match   TexSubTodo            "%%.*" contains=TexTODO
syntax match   TexIgnore             "\\\(%\|{\|}\|\$\|#\|&\|!\|\^\|,\|;\|:\|`\|'\|\"\|_\|=\||\|\[\|\]\)"
syntax match   TexSubPreambleFirst   "\\\<\(NeedsTeXFormat\|documentclass\|ProvidesPackage\)\>" contains=@NoSpell
syntax match   TexSubPreambleCommand "\\\<\(usepackage\|newcommand\|renewcommand\)\>"           contains=@NoSpell
syntax match   TexSubArguments       "#\d\>"
syntax region  TexMaths              matchgroup=TexDollar start="\$" end="\$" contains=@NoSpell,TexCommand,TexIgnore,TexSubLR,TexSubRef
syntax region  TexEnviron            start="\\\(begin\|end\){" end="}" contains=TexBeginEnd,TexDocEnv,TikzPicEnv,BeamerEnv,AmsthmEnv,TexFigEnv
syntax region  TexSubRefEnviron      start="\\\(label\|ref\|pageref\|eqref\){" end="}" contains=@NoSpell,TexSubRef,TexSubRefExtra,TexSubCiteExtra

highlight def link TexCommand            Green
highlight def link TexComment            Comment
highlight def link TexDollar             Grey
highlight def link TexAnd                Orange
highlight def link TexBeginEnd           Yellow
highlight def link TexTagItem            Yellow
highlight def link TexSubFoot            Orange
highlight def link TexSubRef             Orange
highlight def link TexSubCite            Orange
highlight          TexSection            ctermfg=214 cterm=bold guifg=#d9bb80 gui=bold
highlight          TexSubLR              ctermfg=240 guifg=#666666
highlight          TexTODO               ctermfg=175 cterm=bold,italic guifg=#d3a0bc gui=bold
highlight def link TexSubTodo            Todo
highlight def link TexIgnore             Yellow
highlight          TexSubPreambleFirst   ctermfg=208 cterm=bold guifg=#e39b7b gui=bold
highlight          TexSubPreambleCommand ctermfg=108 cterm=bold guifg=#87af87 gui=bold
highlight          TexSubArguments       ctermfg=214 guifg=#d9bb80

let b:current_syntax="tex"
