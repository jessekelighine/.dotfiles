" ~/.config/nvim/after/ftplugin/cpp.vim

setlocal commentstring=//\ %s
setlocal shiftwidth=4 softtabstop=4 tabstop=4 smarttab

" LASTMOD:
let b:lastmod_pattern = '^\(\s*\* *Date: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod :call lastmod#Update(b:lastmod_pattern)

" FUNCTION KEYS:
nnoremap <buffer> <F5> :call cpp#Compile()<CR>
nnoremap <buffer> <F6> :call cpp#Compile()<CR>

nnoremap <buffer> <leader>; :call funcargs#DeleteFunction('[a-zA-Z]','[:a-zA-Z0-9_]')<CR>

inoremap <buffer> :qui<Tab>  <Esc>:call snippets#Get("cpp","skeleton.cpp")<CR>
inoremap <buffer> :sign<Tab>  <Esc>:call snippets#Get("cpp","sign.cpp")<CR>
inoremap <buffer> :rcpp<Tab> <Esc>:call snippets#Get("cpp","Rcpp.cpp")<CR>
inoremap <buffer> :arma<Tab> <Esc>:call snippets#Get("cpp","RcppArmadillo.cpp")<CR>
inoremap <buffer> :cl<Tab>   <Esc>:call snippets#Get("cpp","class.cpp")<CR>/<++><CR>ca<
inoremap <buffer> :bl<Tab>   <Esc>:call snippets#Get("cpp","block.cpp")<CR>/<++><CR>ca<
inoremap <buffer> :h<Tab>    <Esc>:call snippets#Get("cpp","header.cpp")<CR>/<++><CR>ca<
inoremap <buffer> :c<Tab>   /*<Space><Space>*/<left><left><left>

inoremap <buffer> :c<Tab>   /*<Space><Space>*/<left><left><left>

inoremap <buffer><silent> {<CR>      <C-R>=getline(".")[col(".")-1]=="" ? "{\r}\e\<S-O>" : "{\r"<CR>
inoremap <buffer> :for<Tab>  for ( int i { 0 }; i < ; i++ )<Esc>F<<Right>a
inoremap <buffer> :forj<Tab> for ( int j { 0 }; j < ; j++ )<Esc>F<<Right>a
inoremap <buffer> :fork<Tab> for ( int k { 0 }; k < ; k++ )<Esc>F<<Right>a
inoremap <buffer> :out<Tab>  std::cout <<  << std::endl;<Esc>F<;;<Right>a
inoremap <buffer> :in<Tab>   std::cin >> ;<Left>
inoremap <buffer> :str<Tab>  std::string
inoremap <buffer> :strv<Tab>  std::string_view
" imap     <buffer> forr<Tab> for ( <++>; <++>; <++> )<esc>%<leader>]
" imap     <buffer> fori<Tab> for ( auto cursor = <++>.begin(); cursor != <++>.end(); cursor++ )<esc>%<leader>]
" imap     <buffer> fora<Tab> for ( <++> : <++> )<esc>%<leader>]
