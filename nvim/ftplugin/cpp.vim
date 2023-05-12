" ~/.config/nvim/ftplugin/cpp.vim
" ~/.config/nvim/after/ftplugin/cpp.vim
" ~/.config/nvim/autoload/cpp.vim
" ~/.config/nvim/snippets/cpp

setlocal commentstring=//\ %s
setlocal shiftwidth=8 softtabstop=8 tabstop=8 smarttab
command! -buffer -nargs=0 LastMod :call my#LastMod('^\(\s*\* *Date: *\)[^ ]*',10)

" FUNCTION KEYS: complie and run
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/cpp.vim<CR>
nnoremap <buffer> <F5> :call cpp#Compile()<CR>
nnoremap <buffer> <F6> :call cpp#Compile()<CR>

nnoremap <buffer> <leader>; :call my#DelFuncCall('[a-zA-Z]','[:a-zA-Z0-9_]')<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call my#GetSnippets("cpp","skeleton.cpp")<CR>
inoremap <buffer> :sign<Tab>  <Esc>:call my#GetSnippets("cpp","sign.cpp")<CR>
inoremap <buffer> :rcpp<Tab> <Esc>:call my#GetSnippets("cpp","Rcpp.cpp")<CR>
inoremap <buffer> :arma<Tab> <Esc>:call my#GetSnippets("cpp","RcppArmadillo.cpp")<CR>
inoremap <buffer> :cl<Tab>   <Esc>:call my#GetSnippets("cpp","class.cpp")<CR>/<++><CR>ca<
inoremap <buffer> :c<Tab>   /*<Space><Space>*/<left><left><left>

inoremap <buffer> {<CR>      {}<Esc>i<CR><Esc><S-O>
inoremap <buffer> :for<Tab>  for ( int i { 0 }; i < ; i++ )<Esc>F<<Right>a
inoremap <buffer> :forj<Tab> for ( int j { 0 }; j < ; j++ )<Esc>F<<Right>a
inoremap <buffer> :out<Tab>  std::cout <<  << '\n';<Esc>F<;;<Right>a
inoremap <buffer> :in<Tab>   std::cin >> ;<Left>
inoremap <buffer> :str<Tab>  std::string
inoremap <buffer> :strv<Tab>  std::string_view
" imap     <buffer> forr<Tab> for ( <++>; <++>; <++> )<esc>%<leader>]
" imap     <buffer> fori<Tab> for ( auto cursor = <++>.begin(); cursor != <++>.end(); cursor++ )<esc>%<leader>]
" imap     <buffer> fora<Tab> for ( <++> : <++> )<esc>%<leader>]
