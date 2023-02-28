" ~/.vim/after/syntax/tex/fig.vim

syntax match TexFigEnv "{\zs\(figure\|subfigure\|table\)\ze}" contained

highlight TexFigEnv ctermfg=109 guifg=#89beba
" cterm=bold
