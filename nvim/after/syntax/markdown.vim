" ~/.config/nvim/after/syntax/markdown.vim
" ~/.config/nvim/syntax/markdown.vim

" Minimum highlighting of yaml header (copied from vim82)
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

" added by me (migrated from after/syntax)
syntax match   MarkdownEscapeDollar /\\\$/
syntax match   MarkdownListExpand   "^\s*\(-\|+\|\*\|\d\{-}\.\|(\d.\{-})\)\s"
syntax region  MarkdownComment      start="<!--" end="-->" contains=MarkdownTODO
syntax region  MarkdownTexMath      matchgroup=MarkdownTexDollar start="\$"   end="\$"   contains=@NoSpell
syntax region  MarkdownTexMathEnv   matchgroup=MarkdownTexDollar start="\$\$" end="\$\$" contains=@NoSpell
syntax keyword MarkdownTODO         TODO

highlight def link MarkdownEscapeDollar SpecialChar
highlight def link MarkdownListExpand   Red
highlight def link MarkdownTexDollar    Grey
highlight def link MarkdownTexMath      String
highlight def link MarkdownTexMathEnv   String
highlight def link MarkdownComment      Comment
highlight def link MarkdownTODO         Todo

" Footnote ( 2023-02-16 )
syntax region      markdownFootnotes matchgroup=markdownFootnotesBounds start="\^\[" skip="\\]" end="\]"
highlight def link markdownFootnotes       String
highlight def link markdownFootnotesBounds Grey
