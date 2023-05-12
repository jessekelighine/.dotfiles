" ~/.vim/after/syntax/tex/fig.vim

syntax match TexFigEnv "{\zs\(figure\|subfigure\|table\|sidewaystable\)\ze}" contained

highlight TexFigEnv ctermfg=109 guifg=#89beba
" cterm=bold
