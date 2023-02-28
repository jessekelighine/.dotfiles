" ~/.config/nvim/ftplugin/csv.vim
" ~/.config/nvim/autoload/csv.vim

setlocal noexpandtab shiftwidth=16 softtabstop=16 tabstop=16

nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/ftplugin/csv.vim<CR>
nnoremap <buffer> <F2>      :tabnew ~/.config/nvim/after/syntax/csv.vim<CR>
nnoremap <buffer> <Space>   :call csv#GoToColumn()<CR>
nnoremap <buffer> <leader>; :call csv#HighlightColumn()<CR>
nnoremap <buffer> )         :call csv#PrevNextColumn('next')<CR>
nnoremap <buffer> (         :call csv#PrevNextColumn('prev')<CR>

let b:csv_delim               = ","
let b:csv_column              = 1
let b:csv_column_name         = ""
let b:csv_total_column_number = 0
let g:csv_register            = "9"

command! -buffer -nargs=* Delim         :call csv#SetDelim(<args>)
command! -buffer -nargs=? HiCol         :call csv#HighlightColumn(<args>)
command! -buffer -nargs=0 InitializeCSV :call csv#InitializeCSV()

call csv#InitializeCSV()
