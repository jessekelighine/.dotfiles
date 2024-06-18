" ~/.config/nvim/after/syntax/markdown.vim

""" Miscellaneous """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax keyword MarkdownTODO TODO
syntax region  MarkdownComment start="<!--" end="-->" contains=MarkdownTODO
syntax match   markdownDiv /^:::.*$/
syntax match   MarkdownListExpand "^\s*\(-\|+\|\*\|\d\{-}\.\|(\d.\{-})\)\s"

highlight def link MarkdownComment    Comment
highlight def link MarkdownTODO       Todo
highlight def link markdownDiv        Todo
highlight def link MarkdownListExpand Red

""" LaTeX Math Mode (2024-06-18) """"""""""""""""""""""""""""""""""""""""""""""

syntax match  MarkdownEscapeDollar /\\\$/
syntax match  MarkdownTexCommand   /\\\{1,2}/ containedin=MarkdownTexMath
syntax match  MarkdownTexCommand   /\\[a-zA-Z]\+/ containedin=MarkdownTexMath contains=@NoSpell
syntax match  MarkdownTexAnd       /&/ containedin=MarkdownTexMath
syntax match  MarkdownTexIgnore    /\\\(%\|{\|}\|\$\|#\|&\|!\|\^\|,\|;\|:\|`\|'\|\"\|_\|=\||\|\[\|\]\|\~\)/ containedin=MarkdownTexMath
syntax match  MarkdownTexLR        /\\\(left\|right\|middle\)\>/  containedin=MarkdownTexMath contains=@NoSpell
syntax match  MarkdownTexLR        /\\\(big\|Big\|Bigg\)[lr]\?\>/ containedin=MarkdownTexMath contains=@NoSpell
syntax match  MarkdownTexBeginEnd  /\\\(begin\|end\)\>/           containedin=MarkdownTexEnvironment
syntax match  MarkdownTexEnv       /{\zs[a-zA-Z]\+\ze\*\{0,1}}/   containedin=MarkdownTexEnvironment
syntax region MarkdownTexEnvironment start="\\\(begin\|end\){" end="}" containedin=MarkdownTexMath contains=@NoSpell,MarkdownTexEnv,MarkdownTexBeginEnd
syntax region MarkdownTexMath matchgroup=MarkdownTexDollar start="\$"   end="\$"   contains=@NoSpell,MarkdownTexCommand,MarkdownTexAnd,MarkdownTexIgnore,MarkdownTexLR,MarkdownTexEnvironment
syntax region MarkdownTexMath matchgroup=MarkdownTexDollar start="\$\$" end="\$\$" contains=@NoSpell,MarkdownTexCommand,MarkdownTexAnd,MarkdownTexIgnore,MarkdownTexLR,MarkdownTexEnvironment

highlight MarkdownTexLR ctermfg=238 guifg=#444444

highlight def link MarkdownEscapeDollar SpecialChar
highlight def link MarkdownTexCommand   Macro
highlight def link MarkdownTexAnd       Tag
highlight def link MarkdownTexIgnore    SpecialChar
highlight def link MarkdownTexDollar    SpecialComment
highlight def link MarkdownTexBeginEnd  Keyword
highlight def link MarkdownTexEnv       Identifier

""" Minimum Highlighting of YAML Header """""""""""""""""""""""""""""""""""""""

" syntax match  rmdYamlFieldTtl  /^\s*\zs[a-zA-Z0-9-]*\ze:/ contained
" syntax match  rmdYamlFieldTtl  /^\s*-\s*\zs\w*\ze:/ contained
" syntax region yamlFlowString   matchgroup=yamlFlowStringDelimiter start='"' skip='\\"' end='"' contains=yamlEscape,rmdrInline contained
" syntax region yamlFlowString   matchgroup=yamlFlowStringDelimiter start="'" skip="''"  end="'" contains=yamlSingleEscape,rmdrInline contained
" syntax match  yamlEscape       contained '\\\%([\\"abefnrtv\^0_ NLP\n]\|x\x\x\|u\x\{4}\|U\x\{8}\)'
" syntax match  yamlSingleEscape contained "''"
" syntax region pandocYAMLHeader matchgroup=rmdYamlBlockDelim start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=rmdYamlFieldTtl,yamlFlowString
"
" highlight def link rmdYamlBlockDelim Delimiter
" highlight def link rmdYamlFieldTtl Identifier
" highlight def link yamlFlowString String

""" Footnote ( 2023-02-16 ) """""""""""""""""""""""""""""""""""""""""""""""""""

" syntax region      markdownFootnotes matchgroup=markdownFootnotesBounds start="\^\[" skip="\\]" end="\]"
" highlight def link markdownFootnotes       String
" highlight def link markdownFootnotesBounds Grey
