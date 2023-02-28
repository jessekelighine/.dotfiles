" ~/.config/nvim/after/syntax/csv.vim

syntax match CsvHeading /\%1l\(\("\zs\([^"]\|""\)*\ze"\)\|\(\zs[^,\t"]*\ze\)\)/

highlight CsvHeading ctermfg=214 cterm=bold guifg=#d9bb80 gui=bold
