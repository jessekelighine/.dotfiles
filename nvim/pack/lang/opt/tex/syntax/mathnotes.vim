" ~/.vim/after/syntax/tex/mathnotes.vim

syntax match AmsthmEnv "{\zs\(assumption\|lemma\|corollary\|example\|remark\|proposition\|problem\|question\|theorem\|definition\|proof\|claim\|axiom\)\ze\*\=}" contained

highlight def link AmsthmEnv Blue
