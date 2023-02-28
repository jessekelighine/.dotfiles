" ~/.vim/after/syntax/tex/document.vim

syntax match TexDocEnv "{\zsdocument\ze}" contained

highlight TexDocEnv cterm=underline,bold gui=underline,bold
