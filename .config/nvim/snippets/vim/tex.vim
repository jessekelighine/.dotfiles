" vimrc for TeX files

let s:labs_files = glob("./*.tex", 0, 1)
let s:bibs_files = glob("./*.bib", 0, 1)
call texcomplete#SetFiles("labs", s:labs_files)
call texcomplete#SetFiles("bibs", s:bibs_files)

call textoggle#Begin()
Load algorithm
Load beamer
Load glossary
Load mathnotes
Load plaintex
Load tikz
call textoggle#End()

Spell 1
ServerSetup
