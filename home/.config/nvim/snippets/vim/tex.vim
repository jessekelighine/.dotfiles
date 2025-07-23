" vimrc for TeX files

let s:labs_files = glob("./*.tex", 0, 1)
let s:bibs_files = glob("./*.bib", 0, 1)
call tex_complete#SetFiles("labs", s:labs_files)
call tex_complete#SetFiles("bibs", s:bibs_files)

call tex_toggle#Begin()
Load algorithm
Load beamer
Load glossary
Load mathnotes
Load plaintex
Load tikz
call tex_toggle#End()

Spell 1
ServerSetup
