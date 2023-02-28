" ~/.config/nvim/syntax/tex.vim
" ~/.config/nvim/pack/lang/opt/tex/syntax

if exists("b:current_syntax") | finish | endif

syntax keyword TexTODO          TODO contained
syntax match   TexCommand       "\\\{1,2}"
syntax match   TexCommand       "\\[a-zA-Z]\+" contains=@NoSpell
syntax match   TexSubAnd        "&"
syntax match   TexBeginEnd      "\\\(begin\|end\)\>" contained
syntax match   TexTagItem       "\\\(item\|tag\)\>"
syntax match   TexSubRef        "\\\(label\|ref\|pageref\|eqref\)\>" contains=@NoSpell
syntax match   TexSubLR         "\\\(left\|right\|big\|Big\|middle\|Bigg\)\>" contains=@NoSpell
syntax match   TexSubFoot       "\\\(footnotemark\|footnote\)\>" contains=@NoSpell
syntax match   TexSection       "\\\(sub\)\{0,2}\(section\|paragraph\|chapter\)\>" contains=@NoSpell
syntax match   TexSection       "\\appendix\>"
syntax match   TexComment       "%.*"  contains=@NoSpell,TexTODO
syntax match   TexSubTodo       "%%.*" contains=TexTODO
syntax match   TexSubIgnore     "\\\(%\|{\|}\|\$\|#\|&\|!\|\^\|,\|;\|:\|`\|'\|\"\|_\|=\||\|\[\|\]\)"
syntax region  TexSubMaths      matchgroup=TexSubDollar start="\$" end="\$" contains=@NoSpell,TexCommand,TexSubIgnore,TexSubLR,TexSubRef
syntax region  TexEnviron       start="\\\(begin\|end\){" end="}" contains=TexBeginEnd,TexDocEnv,TikzPicEnv,BeamerEnv,AmsthmEnv,TexFigEnv
syntax region  TexSubRefEnviron start="\\\(label\|ref\|pageref\|eqref\){" end="}" contains=@NoSpell,TexSubRef,TexSubRefExtra,TexSubCiteExtra

highlight def link TexCommand   Green
highlight def link TexComment   Comment
highlight def link TexSubDollar Grey
highlight def link TexSubAnd    Orange
highlight def link TexBeginEnd  Yellow
highlight def link TexTagItem   Yellow
highlight def link TexSubFoot   Orange
highlight def link TexSubRef    Orange
highlight          TexSection   ctermfg=214 cterm=bold guifg=#d9bb80 gui=bold
highlight          TexSubLR     ctermfg=240 guifg=#666666
highlight          TexTODO      ctermfg=175 cterm=bold,italic guifg=#d3a0bc gui=bold
highlight def link TexSubTodo   Todo
highlight def link TexSubIgnore Yellow

let b:current_syntax="tex"
