" ~/.vim/after/syntax/tex/beamer.vim

syntax match BeamerEnv "{\zs\(frame\|block\)\ze}" contained

highlight def link BeamerEnv Blue
