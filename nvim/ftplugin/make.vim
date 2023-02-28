" ~/.config/nvim/ftplugin/make.vim
" ~/.config/nvim/snippets/make

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/make.vim<CR>

inoremap <buffer> :tex<Tab>  <Esc>:call my#GetSnippets('make','make_tex_skeleton')<CR>
inoremap <buffer> :main<Tab> <Esc>:call my#GetSnippets('make','make_tex_main')<CR>
inoremap <buffer> :tikz<Tab> <Esc>:call my#GetSnippets('make','make_tex_tikz')<CR>
inoremap <buffer> :rm<Tab>   <Esc>:call my#GetSnippets('make','make_tex_rm')<CR>
inoremap <buffer> :r<Tab>    <Esc>:call my#GetSnippets('make','make_tex_R')<CR>
inoremap <buffer> :ph<Tab>   <Esc>:call my#GetSnippets('make','make_phony')<CR>
