" ~/.config/nvim/after/ftplugin/vim.vim
" ~/.config/nvim/lua/cmp/vim.lua
" ~/.config/nvim/snippets/vim/

setlocal commentstring=\"\ %s
let b:match_words = ""
			\ .. '\<function\>:\<endfunction\>,'
			\ .. '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
			\ .. '\<for\>:\<endfor\>,'
			\ .. '\<while\>:\<endwhile\>,'

nnoremap <buffer> <leader>; :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z#0-9_]')<CR>
