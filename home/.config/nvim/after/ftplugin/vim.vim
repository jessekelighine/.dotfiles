" ~/.config/nvim/after/ftplugin/vim.vim
" ~/.config/nvim/snippets/vim/

setlocal commentstring=\"\ %s
let b:match_words = ""
			\ .. '\<function\>:\<endfunction\>,'
			\ .. '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
			\ .. '\<for\>:\<endfor\>,'
			\ .. '\<while\>:\<endwhile\>,'

nnoremap <buffer>       <F1>      :tabnew ~/.config/nvim/after/ftplugin/vim.vim<CR>
nnoremap <buffer>       <leader>; :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z#0-9_]')<CR>
inoremap <buffer><expr> :pwd<Tab> expand('%:p')
inoremap <buffer><expr> :fn<Tab>  expand('%:t')

inoremap <buffer> :tex<Tab>      <Esc>:call snippets#Get("vim","tex.vim")<CR>
inoremap <buffer> :markdown<Tab> <Esc>:call snippets#Get("vim","markdown.vim")<CR>
