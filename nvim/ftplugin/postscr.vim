" ~/.config/nvim/ftplugin/postscr.vim

setlocal commentstring=%\ %s
let g:surround_103="gsave\rgrestore"
let g:surround_98 ="begin\rend"

" UTILITIES: often used utilities.
nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/ftplugin/postscr.vim<CR>
nnoremap <buffer> <F2>      :tabnew ~/.config/nvim/after/syntax/postscr.vim<CR>
nnoremap <buffer> <F5>      :call postscr#Convert()<CR>
nnoremap <buffer> <leader>p :!open %:r.pdf<CR><CR>

" SNIPPETS:
inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets('postscr','qui.eps')<CR>
inoremap <buffer> :cm<Tab>   <Esc>:call my#GetSnippets('postscr','unit_cm.eps')<CR>
inoremap <buffer> :inch<Tab> <Esc>:call my#GetSnippets('postscr','unit_inch.eps')<CR>

" INSERT MAPPINGS:
inoremap <buffer> {<CR>      {<CR><Space><CR>}<Esc>0kA<BackSpace>
inoremap <buffer> %<Tab>     %%%<Space><Space>%%%<Left><Left><Left><Left>
inoremap <buffer> begin<Tab> begin<CR>end<Esc>k

" gs -q -dNOCACHE -dNOPAUSE -dBATCH -dSAFER -sDEVICE=eps2write -sOutputFile=wo.eps wo.pdf
