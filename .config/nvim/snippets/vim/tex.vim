" vimrc

let s:labs_files = glob("./*.tex", 0, 1)
let s:bibs_files = [ "references.bib" ]
call texcomplete#SetFiles('labs', s:labs_files)
call texcomplete#SetFiles('bibs', s:bibs_files)

call textoggle#Clear()
call textoggle#Set('acronym')
call textoggle#Set('algorithm')
call textoggle#Set('beamer')
call textoggle#Set('notes')
call textoggle#Set('plaintex')
call textoggle#Set('tikz')
call textoggle#Reload()

Spell 1
ConcealToggle 2
ServerSetup
