" ~/.config/nvim/after/ftplugin/csv.vim
" ~/.config/nvim/after/syntax/csv.vim
" ~/.config/nvim/autoload/csv.vim

let b:csv_delim               = ","
let b:csv_column              = 1
let b:csv_column_name         = ""
let b:csv_total_column_number = 0
let g:csv_register            = "9"

setlocal noexpandtab shiftwidth=20 softtabstop=20 tabstop=20

command! -buffer -nargs=* Delim         :call csv#SetDelim(<args>)
command! -buffer -nargs=? HiCol         :call csv#HighlightColumn(<args>)
command! -buffer -nargs=0 InitializeCSV :call csv#InitializeCSV()
command! -buffer -nargs=0 FindColumn    :call csv#FindColumn()
command! -buffer -nargs=0 HeadingHighlight :source ~/.config/nvim/after/syntax/csv.vim

nnoremap <silent><buffer> <Space>   <Cmd>call csv#GoToColumn()<CR>
nnoremap <silent><buffer> <leader>; <Cmd>call csv#HighlightColumn()<CR>
nnoremap <silent><buffer> )         <Cmd>call csv#PrevNextColumn('next')<CR>
nnoremap <silent><buffer> (         <Cmd>call csv#PrevNextColumn('prev')<CR>

call csv#InitializeCSV()
HeadingHighlight
