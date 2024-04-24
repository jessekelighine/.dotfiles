" ~/.config/nvim/after/syntax/markdown.vim
" ~/.config/nvim/syntax/markdown.vim

""" Minimum highlighting of yaml header (copied from vim) """""""""""""""""""""

syntax match  rmdYamlFieldTtl  /^\s*\zs[a-zA-Z0-9-]*\ze:/ contained
syntax match  rmdYamlFieldTtl  /^\s*-\s*\zs\w*\ze:/ contained
syntax region yamlFlowString   matchgroup=yamlFlowStringDelimiter start='"' skip='\\"' end='"' contains=yamlEscape,rmdrInline contained
syntax region yamlFlowString   matchgroup=yamlFlowStringDelimiter start="'" skip="''"  end="'" contains=yamlSingleEscape,rmdrInline contained
syntax match  yamlEscape       contained '\\\%([\\"abefnrtv\^0_ NLP\n]\|x\x\x\|u\x\{4}\|U\x\{8}\)'
syntax match  yamlSingleEscape contained "''"
syntax region pandocYAMLHeader matchgroup=rmdYamlBlockDelim start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=rmdYamlFieldTtl,yamlFlowString

highlight def link rmdYamlBlockDelim Delimiter
highlight def link rmdYamlFieldTtl Identifier
highlight def link yamlFlowString String

""" LaTeX Math Mode (2023-12-30) """"""""""""""""""""""""""""""""""""""""""""""

" This part is largely copied from the `vim-bunttex` syntax for LaTeX.

syntax region  TexMaths           matchgroup=TexDollar start="\$" end="\$" contains=@NoSpell,TexCommand,TexIgnore,TexLR

syntax match  MarkdownTexAnd       "&" contained
syntax match  MarkdownEscapeDollar /\\\$/
syntax match  MarkdownTexCommand   /\\[a-zA-Z]\+/ contained
syntax match  MarkdownTexIgnore    /\\\(%\|{\|}\|\$\|#\|&\|!\|\^\|,\|;\|:\|`\|'\|\"\|_\|=\||\|\[\|\]\|\~\)/ contained
syntax match  MarkdownTexLR        /\\\(left\|right\|big\|Big\|middle\|Bigg\)\>/ contained
syntax match  MarkdownTexBeginEnd  "\\\(begin\|end\)\>" contained
syntax region MarkdownTexMath      matchgroup=MarkdownTexDollar start="\$"   end="\$"   contains=@NoSpell,MarkdownTexCommand,MarkdownTexIgnore,MarkdownTexLR,MarkdownTexBeginEnd,MarkdownTexAnd
syntax region MarkdownTexMath      matchgroup=MarkdownTexDollar start="\$\$" end="\$\$" contains=@NoSpell,MarkdownTexCommand,MarkdownTexIgnore,MarkdownTexLR,MarkdownTexBeginEnd,MarkdownTexAnd

highlight def link MarkdownEscapeDollar SpecialChar
highlight def link MarkdownTexDollar    Grey
highlight def link MarkdownTexCommand   Green
highlight def link MarkdownTexAnd       Orange
highlight def link MarkdownTexIgnore    Yellow
highlight def link MarkdownTexBeginEnd  Red
highlight          MarkdownTexLR        ctermfg=240 guifg=#666666

""" Miscellaneous """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax keyword MarkdownTODO TODO
syntax region MarkdownComment start="<!--" end="-->" contains=MarkdownTODO
syntax match MarkdownListExpand "^\s*\(-\|+\|\*\|\d\{-}\.\|(\d.\{-})\)\s"

highlight def link MarkdownComment Comment
highlight def link MarkdownTODO Todo
highlight def link MarkdownListExpand Red

""" Footnote ( 2023-02-16 ) """""""""""""""""""""""""""""""""""""""""""""""""""

syntax region      markdownFootnotes matchgroup=markdownFootnotesBounds start="\^\[" skip="\\]" end="\]"
highlight def link markdownFootnotes       String
highlight def link markdownFootnotesBounds Grey

""" Div ( 2024-04-15 ) """"""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax match markdownDiv /^:::.*$/
highlight def link markdownDiv Todo
