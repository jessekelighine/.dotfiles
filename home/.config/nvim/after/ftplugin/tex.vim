" ~/.config/nvim/after/ftplugin/tex.vim
" ~/.config/nvim/after/ftplugin/tex.lua
" ~/.config/nvim/lua/cmp/tex.lua
" ~/.config/nvim/after/indent/tex.vim
" ~/.config/nvim/autoload/tex.vim
" ~/.config/nvim/autoload/tex_toggle.vim
" ~/.config/nvim/autoload/tex_complete.vim
" ~/.config/nvim/snippets/tex/
" ~/.config/nvim/pack/lang/opt/tex/
" ~/.local/share/nvim/lazy/vim-bunttex/

" SETTINGS: fast syntax, comment, spell, indent environment.
setlocal synmaxcol=200
setlocal commentstring=%\ %s
setlocal spellfile=~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/latex.utf-8.add
setlocal foldmethod=manual
setlocal foldnestmax=1
let g:tex_noindent_env = 'document\|verbatim\|lstlisting\|multicols\|letter\|appendix\|spacing'
let g:tex_indent_brace = 0
let b:match_words ..= ','
			\ .. '\\left\>:\\right\>,'
			\ .. '\\bigl\>:\\bigr\>,'
			\ .. '\\Bigl\>:\\Bigr\>,'
			\ .. '\\Biggl\>:\\Biggr\>,'
			\ .. '\\makeatletter\>:\\makeatother\>,'

" SURROUND: surround settings.
let b:surround_indent = 1
let b:surround_66  = "\\Big\r\\Big"
let b:surround_98  = "\\big\r\\big"
let b:surround_67  = "\\left\\{\r\\right."
let b:surround_81  = "``\r''"
let b:surround_113 = "`\r'"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"
let b:surround_108 = "\\left\r\\right"
let b:surround_103 = "($\r$)"

" COMPILATION:
let b:tex_compile_png = "xelatex " .. "'" .. expand("%") .. "'" .. "; "
			\ .. "convert "
			\ .. "-background '#FFFFFF' -flatten "
			\ .. "-density 600 "
			\ .. "'" .. expand("%:r") .. ".pdf" .. "'" .. " "
			\ .. "'" .. expand("%:r") .. ".png" .. "'"
let b:tex_compile_xelatex = "latexmk -pdfxe -pvc -synctex=1 -view=none " .. "'" .. expand("%") .. "'"
let b:tex_compile_make    = "make; echo . | whenever make"
let b:tex_compile_command = filereadable("Makefile") ? b:tex_compile_make : b:tex_compile_xelatex
nnoremap <silent><buffer> <leader>rq       <Cmd>call vimslime#CloseTmux()<CR>
nnoremap <silent><buffer> <leader>rf       <Cmd>call vimslime#OpenTmux(b:tex_compile_command)<CR>
nnoremap <silent><buffer> <leader><Space>  <Cmd>call vimslime#OpenTmux(b:tex_compile_command)<CR>
nnoremap <silent><buffer> <leader><leader> <Cmd>call vimslime#Send("\<C-D>")<CR>
" command! -buffer -nargs=0 OpenTmuxLatexmk :call vimslime#OpenTmux(b:tex_compile_xelatex)
" command! -buffer -nargs=0 OpenTmuxMake    :call vimslime#OpenTmux(b:tex_compile_make)
" nnoremap <silent><buffer><expr> <Space><Space> vimslime#Send("\<C-D>")

" UTILITIES: utilities.
command! -buffer -nargs=0 ServerSetup call tex#ServerSetup()
command! -buffer -nargs=0 ReloadTeX   call tex_toggle#Reload()
command! -buffer -nargs=0 FindSection call tex#FindSection()
command! -buffer -nargs=0 JunkRemove  ! latexmk -C %:r
command! -buffer -nargs=0 WordCount   ! texcount %:p
nnoremap <buffer><silent> <leader>S <Cmd>call tex#ServerSetup()<CR>
nnoremap <buffer><silent> <leader>c <Cmd>call tex#EnvironmentChange()<CR>
nnoremap <buffer><silent> <leader>d <Cmd>call tex#EnvironmentDelete()<CR>
nnoremap <buffer><silent> <leader>, <Cmd>call tex#DelLeftRight()<CR>
nnoremap <buffer><silent> <leader>8 <Cmd>call tex#EnvironmentStar()<CR>
nnoremap <buffer><silent> <leader>g <Cmd>call tex#SkimForward()<CR>
nnoremap <buffer><silent> <leader>t <Cmd>call tex_toggle#Master()<CR>
nnoremap <buffer><silent> <leader>; <Cmd>call funcargs#DeleteFunction('\\','[a-zA-Z]','{}')<CR>
nnoremap <buffer><silent> <leader>p <Cmd>call tex#SkimForward()<CR>
" nnoremap <buffer><silent> <leader>p :! open %:r.pdf<CR><CR>
silent ServerSetup

" LASTMOD:
let b:lastmod_pattern = '^\(%* *Last Modified: *\)' .. '[^ ]*' .. '\(.*\)$'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

" COMPLETETION: `Lables` and `Biblography` complete settings.
setlocal completefunc=tex_complete#Labs
setlocal omnifunc=tex_complete#Bibs
command! -buffer -nargs=0 ShowLabs     call tex_complete#Show('labs')
command! -buffer -nargs=0 ShowBibs     call tex_complete#Show('bibs')
command! -buffer -nargs=0 GenerateLabs call tex_complete#GenerateLabs()
command! -buffer -nargs=0 GenerateBibs call tex_complete#GenerateBibs()
" command! -buffer -nargs=1 SetLabsFiles :call tex_complete#SetFiles('labs',<args>)
" command! -buffer -nargs=1 SetBibsFiles :call tex_complete#SetFiles('bibs',<args>)

" LATEX ARGUMENTS:
xnoremap <silent><buffer> ia <Esc>:call funcargs#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
xnoremap <silent><buffer> aa <Esc>:call funcargs#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> ia      :call funcargs#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> aa      :call funcargs#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>

" LATEX QUOTES:
inoremap <silent><buffer>  `<Tab> <C-G>u`'<Left>
inoremap <silent><buffer> ``<Tab> <C-G>u``''<Left><Left>
xnoremap <silent><buffer> iQ :<C-U>call tex#Quotes("i",1)<CR>
xnoremap <silent><buffer> aQ :<C-U>call tex#Quotes("a",1)<CR>
onoremap <silent><buffer> iQ :<C-U>call tex#Quotes("i",1)<CR>
onoremap <silent><buffer> aQ :<C-U>call tex#Quotes("a",1)<CR>
onoremap <silent><buffer> QQ :<C-U>call tex#Quotes("q",1)<CR>
xnoremap <silent><buffer> iq :<C-U>call tex#Quotes("i",0)<CR>
xnoremap <silent><buffer> aq :<C-U>call tex#Quotes("a",0)<CR>
onoremap <silent><buffer> iq :<C-U>call tex#Quotes("i",0)<CR>
onoremap <silent><buffer> aq :<C-U>call tex#Quotes("a",0)<CR>
onoremap <silent><buffer> qq :<C-U>call tex#Quotes("q",0)<CR>

" LATEX TEXT OBJECTS:
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
xnoremap <silent><buffer> a<bar> <Esc>:norm! F<bar>vf<bar><CR>
onoremap <silent><buffer> i<bar> :norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> a<bar> :norm! F<bar>vf<bar><CR>
xnoremap <silent><buffer> i$     <Esc>:norm! F$lvt$<CR>
xnoremap <silent><buffer> a$     <Esc>:norm! F$vf$<CR>
onoremap <silent><buffer> i$     :norm! F$lvt$<CR>
onoremap <silent><buffer> a$     :norm! F$vf$<CR>

" MATH:
inoremap <buffer> _<Tab>           <C-G>u_{}<Left>
inoremap <buffer> ^<Tab>           <C-G>u^{}<Left>
inoremap <buffer> $<Tab>           <C-G>u$$<Left>
inoremap <buffer> ]<Tab>           <C-G>u\left[\right]<Esc><S-F>[a
inoremap <buffer> )<Tab>           <C-G>u\left(\right)<Esc><S-F>(a
inoremap <buffer> }<Tab>           <C-G>u\left\{\right\}<Esc><S-F>{a
inoremap <buffer> {{<Tab>          <C-G>u\{\}<Esc><S-F>{a
inoremap <buffer> <bar><Tab>       <C-G>u<bar><bar><Left>
inoremap <buffer> <bar><bar><Tab>  <C-G>u\left<bar>\right<bar><Esc>6hi
inoremap <buffer> \<bar><Tab>      <C-G>u\<bar>\<bar><Left><Left>
inoremap <buffer> \<bar><bar><Tab> <C-G>u\left\<bar>\right\<bar><Esc>7hi
inoremap <buffer> $$<Tab>          <C-G>u$$<CR>$$<Esc>O
inoremap <buffer> $$<CR>           <C-G>u$$<CR>$$<Esc>O
