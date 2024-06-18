" ~/.vim/after/ftplugin/tex/mathnotes.vim

" MATH NOTES: amsthm package.
inoremap <buffer> \cor<Tab>  <Esc>:call tex#EmptyEnvironment('corollary')<CR>
inoremap <buffer> \dfn<Tab>  <Esc>:call tex#EmptyEnvironment('definition')<CR>
inoremap <buffer> \eg<Tab>   <Esc>:call tex#EmptyEnvironment('example')<CR>
inoremap <buffer> \lem<Tab>  <Esc>:call tex#EmptyEnvironment('lemma')<CR>
inoremap <buffer> \pf<Tab>   <Esc>:call tex#EmptyEnvironment('proof')<CR>
inoremap <buffer> \prop<Tab> <Esc>:call tex#EmptyEnvironment('proposition')<CR>
inoremap <buffer> \rmk<Tab>  <Esc>:call tex#EmptyEnvironment('remark')<CR>
inoremap <buffer> \thm<Tab>  <Esc>:call tex#EmptyEnvironment('theorem')<CR>
inoremap <buffer> \ass<Tab>  <Esc>:call tex#EmptyEnvironment('assumption')<CR>
inoremap <buffer> \clm<Tab>  <Esc>:call tex#EmptyEnvironment('claim')<CR>
inoremap <buffer> \axm<Tab>  <Esc>:call tex#EmptyEnvironment('axiom')<CR>
