" hilite.vim

highlight Hilite ctermbg=214 ctermfg=black

let g:hilite_matchaddpos_ids = []

xnoremap <silent> <Plug>(HiliteHilite) :call hilite#Hilite()<CR>
nnoremap <silent> <Plug>(HiliteClear)  :call hilite#Clear()<CR>
