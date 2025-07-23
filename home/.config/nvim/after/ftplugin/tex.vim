" ~/.config/nvim/after/ftplugin/tex.vim
" ~/.config/nvim/after/ftplugin/tex.lua
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

" PREAMBLES:
inoremap <buffer> :qui<tab>     <Esc>:call snippets#Get('tex','skeleton.tex')<CR>
inoremap <buffer> :letter<tab>  <Esc>:call snippets#Get('tex','skeleton-letter.tex')<CR>
inoremap <buffer> :beamer<tab>  <Esc>:call snippets#Get('tex','preamble-beamer.tex')<CR>
inoremap <buffer> :std<tab>     <Esc>:call snippets#Get('tex','preamble-standalone.tex')<CR>
inoremap <buffer> :alg<tab>     <Esc>:call snippets#Get('tex','preamble-algorithm.tex')<CR>
inoremap <buffer> :cjk<tab>     <Esc>:call snippets#Get('tex','preamble-xeCJK.tex')<CR>
inoremap <buffer> :cw<tab>      <Esc>:call snippets#Get('tex','preamble-cwtex.tex')<CR>
inoremap <buffer> :punct<tab>   <Esc>:call snippets#Get('tex','preamble-punct.tex')<CR>
inoremap <buffer> :bib<tab>     <Esc>:call snippets#Get('tex','preamble-biblatex.tex')<CR>
inoremap <buffer> :tit<tab>     <Esc>:call snippets#Get('tex','preamble-title.tex')<CR>
inoremap <buffer> :chenum<tab>  <Esc>:call snippets#Get('tex','preamble-chineseenumerate.tex')<CR>
inoremap <buffer> :chnum<tab>   <Esc>:call snippets#Get('tex','preamble-chinesenumber.tex')<CR>
inoremap <buffer> :color<tab>   <Esc>:call snippets#Get('tex','preamble-color.tex')<CR>
inoremap <buffer> :csv<tab>     <Esc>:call snippets#Get('tex','preamble-csv.tex')<CR>
inoremap <buffer> :cols<tab>    <Esc>:call snippets#Get('tex','preamble-column.tex')<CR>
inoremap <buffer> :ct<tab>      <Esc>:call snippets#Get('tex','preamble-customtitle.tex')<CR>
inoremap <buffer> :enum<tab>    <Esc>:call snippets#Get('tex','preamble-enumerate.tex', { 'indent': 0 })<CR>
inoremap <buffer> :faux<tab>    <Esc>:call snippets#Get('tex','preamble-fauxsc.tex')<CR>
inoremap <buffer> :fig<tab>     <Esc>:call snippets#Get('tex','preamble-graphics.tex')<CR>
inoremap <buffer> :foot<tab>    <Esc>:call snippets#Get('tex','preamble-footnote.tex')<CR>
inoremap <buffer> :font<tab>    <Esc>:call snippets#Get('tex','preamble-font.tex')<CR>
inoremap <buffer> :german<tab>  <Esc>:call snippets#Get('tex','preamble-german.tex')<CR>
inoremap <buffer> :hyper<tab>   <Esc>:call snippets#Get('tex','preamble-hyperreference.tex')<CR>
inoremap <buffer> :lof<tab>     <Esc>:call snippets#Get('tex','preamble-listoffigures.tex')<CR>
inoremap <buffer> :math<tab>    <Esc>:call snippets#Get('tex','preamble-math.tex')<CR>
inoremap <buffer> :mn<tab>      <Esc>:call snippets#Get('tex','preamble-mathnotes.tex')<CR>
inoremap <buffer> :ow<tab>      <Esc>:call snippets#Get('tex','preamble-noorphanwidow.tex')<CR>
inoremap <buffer> :problem<tab> <Esc>:call snippets#Get('tex','preamble-problem.tex')<CR>
inoremap <buffer> :prob<tab>    <Esc>:call snippets#Get('tex','preamble-mathprob.tex')<CR>
inoremap <buffer> :pageb<tab>   <Esc>:call snippets#Get('tex','preamble-pagebeamer.tex')<CR>
inoremap <buffer> :page<tab>    <Esc>:call snippets#Get('tex','preamble-fancyhdr.tex')<CR>
inoremap <buffer> :ruby<tab>    <Esc>:call snippets#Get('tex','preamble-ruby.tex')<CR>
inoremap <buffer> :tab<tab>     <Esc>:call snippets#Get('tex','preamble-table.tex')<CR>
inoremap <buffer> :secf<tab>    <Esc>:call snippets#Get('tex','preamble-sectionfont.tex')<CR>
inoremap <buffer> :set<tab>     <Esc>:call snippets#Get('tex','preamble-package.tex')<CR>
inoremap <buffer> :shrug<tab>   <Esc>:call snippets#Get('tex','preamble-shruggie.tex')<CR>
inoremap <buffer> :sign<tab>    <Esc>:call snippets#Get('tex','preamble-sign.tex')<CR>
inoremap <buffer> :tikz<tab>    <Esc>:call snippets#Get('tex','preamble-tikz.tex')<CR>
inoremap <buffer> :toc<tab>     <Esc>:call snippets#Get('tex','preamble-tableofcontents.tex')<CR>
inoremap <buffer> :udxe<tab>    <Esc>:call snippets#Get('tex','preamble-underdotxe.tex')<CR>
inoremap <buffer> :udcw<tab>    <Esc>:call snippets#Get('tex','preamble-underdotcwtex.tex')<CR>
inoremap <buffer> :verb<tab>    <Esc>:call snippets#Get('tex','preamble-fancyvrb.tex')<CR>
inoremap <buffer> :date<Tab>    <Esc>:call snippets#Get('tex','preamble-datetime.tex')<CR>
inoremap <buffer> :dinkus<Tab>  <Esc>:call snippets#Get('tex','preamble-dinkus.tex')<CR>
inoremap <buffer> :gloss<Tab>   <Esc>:call snippets#Get('tex','preamble-glossaries.tex')<CR>
inoremap <buffer> :btheme<Tab>  <Esc>:call snippets#Get('tex','preamble-beamer_theme.tex')<CR>
inoremap <buffer> :tcolor<Tab>  <Esc>:call snippets#Get('tex','preamble-tcolorbox.tex')<CR>
inoremap <buffer> :minted<Tab>  <Esc>:call snippets#Get('tex','preamble-minted.tex')<CR>
inoremap <buffer> :blind<Tab>   <Esc>:call snippets#Get('tex','indoc-blindtext.tex')<CR>
inoremap <buffer> :blindzh<Tab> <Esc>:call snippets#Get('tex','indoc-blindtext-zh.tex')<CR>

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

" MATH TEXT:
inoremap <buffer> \t<Tab>  <C-G>u\text{}<Left>
inoremap <buffer> \bs<Tab> <C-G>u\boldsymbol{}<Left>
inoremap <buffer> \bb<Tab> <C-G>u\mathbb{}<Left>
inoremap <buffer> \mb<Tab> <C-G>u\mathbold{}<Left>
inoremap <buffer> \mc<Tab> <C-G>u\mathcal{}<Left>
inoremap <buffer> \ms<Tab> <C-G>u\mathscr{}<Left>
inoremap <buffer> \mf<Tab> <C-G>u\mathsf{}<Left>
inoremap <buffer> \mt<Tab> <C-G>u\mathtt{}<Left>
inoremap <buffer> \mr<Tab> <C-G>u\mathrm{}<Left>
inoremap <buffer> \mk<Tab> <C-G>u\mathfrak{}<Left>
