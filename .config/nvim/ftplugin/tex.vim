" ~/.config/nvim/ftplugin/tex.vim
" ~/.config/nvim/after/indent/tex.vim
" ~/.config/nvim/autoload/tex.vim
" ~/.config/nvim/autoload/textoggle.vim
" ~/.config/nvim/autoload/texcomplete.vim
" ~/.config/nvim/snippets/tex/
" ~/.config/nvim/pack/lang/opt/tex/
" ~/.config/nvim/pack/lang/start/vim-bunttex/

" SETTINGS: fast syntax, comment, spell, indent environment.
packadd  matchit
setlocal synmaxcol=200
setlocal commentstring=%\ %s
setlocal spellfile=~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/latex.utf-8.add
setlocal foldmethod=manual
setlocal foldnestmax=1
let g:tex_noindent_env='document\|verbatim\|lstlisting\|multicols\|letter\|appendix'
let g:tex_indent_brace=0

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
let b:tex_compile_png = "xelatex " .. my#quote(expand("%")) .. "; "
			\ .. "convert "
			\ .. "-background '#FFFFFF' -flatten "
			\ .. "-density 600 "
			\ .. my#quote(expand("%:r") .. ".pdf") .. " "
			\ .. my#quote(expand("%:r") .. ".png")
let b:tex_compile_xelatex = "latexmk -pdfxe -pvc -synctex=1 -view=none -halt-on-error " .. my#quote(expand("%"))
let b:tex_compile_make    = "make ; whenever . make"
let b:tex_compile_command = file_readable("Makefile") ? b:tex_compile_make : b:tex_compile_xelatex
nnoremap <silent><buffer> <leader>rq      :call tex#CloseTmux()<CR>
nnoremap <silent><buffer> <leader>rf      :call tex#OpenTmux(b:tex_compile_command)<CR>
nnoremap <silent><buffer> <leader><Space> :call tex#OpenTmux(b:tex_compile_command)<CR>
command! -buffer -nargs=0 OpenTmuxLatexmk :call tex#OpenTmux(b:tex_compile_xelatex)
command! -buffer -nargs=0 OpenTmuxMake    :call tex#OpenTmux(b:tex_compile_make)

" UTILITIES: utilities.
command! -buffer -nargs=0 ServerSetup   :call tex#ServerSetup()
command! -buffer -nargs=0 LastMod       :call my#LastMod('^\(%* *Last Modified: *\)[^ ]*',7)
command! -buffer -nargs=0 ReloadTeX     :call textoggle#Reload(1)
command! -buffer -nargs=0 ShowToggles   :call textoggle#Show()
command! -buffer -nargs=0 ClearToggles  :call textoggle#Clear()
command! -buffer -nargs=0 FindSection   :call tex#FindSection()
command! -buffer -nargs=0 JunkRemove    :! latexmk -C %:r
command! -buffer -nargs=? ConcealToggle :call tex#ConcealToggle(<args>)
nnoremap <buffer><silent> <leader>S     :call tex#ServerSetup()<CR>
nnoremap <buffer><silent> <leader>c     :call tex#EnvironmentChange()<CR>
nnoremap <buffer><silent> <leader>d     :call tex#EnvironmentDelete()<CR>
nnoremap <buffer><silent> <leader>,     :call tex#DelLeftRight()<CR>
nnoremap <buffer><silent> <leader>8     :call tex#EnvironmentStar()<CR>
nnoremap <buffer><silent> <leader>g     :call tex#SkimForward()<CR>
nnoremap <buffer><silent> <leader>t     :call textoggle#Master()<CR>
nnoremap <buffer><silent> <leader>;     :call my#DelFuncCall('\\','[a-zA-Z]','{}')<CR>
nnoremap <buffer><silent> <leader>p     :! open %:r.pdf<CR><CR>
nnoremap <silent><buffer> <F1>          :tabnew ~/.config/nvim/ftplugin/tex.vim<CR>

" COMPLETETION: `Lables` and `Biblography` complete settings.
setlocal completefunc=texcomplete#Labs
setlocal omnifunc=texcomplete#Bibs
command! -buffer -nargs=0 ShowLabs     :call texcomplete#Show('labs')
command! -buffer -nargs=0 ShowBibs     :call texcomplete#Show('bibs')
command! -buffer -nargs=0 GenerateLabs :call texcomplete#GenerateLabs()
command! -buffer -nargs=0 GenerateBibs :call texcomplete#GenerateBibs()
" command! -buffer -nargs=1 SetLabsFiles :call texcomplete#SetFiles('labs',<args>)
" command! -buffer -nargs=1 SetBibsFiles :call texcomplete#SetFiles('bibs',<args>)

" PREAMBLES: stored in "snippets/tex".
inoremap <buffer> :qui<tab>     <Esc>:call my#GetSnippets('tex','skeleton.tex')<CR>
inoremap <buffer> :letter<tab>  <Esc>:call my#GetSnippets('tex','skeleton-letter.tex')<CR>
inoremap <buffer> :beamer<tab>  <Esc>:call my#GetSnippets('tex','preamble-beamer.tex')<CR>
inoremap <buffer> :std<tab>     <Esc>:call my#GetSnippets('tex','preamble-standalone.tex')<CR>
inoremap <buffer> :alg<tab>     <Esc>:call my#GetSnippets('tex','preamble-algorithm.tex')<CR>
inoremap <buffer> :cjk<tab>     <Esc>:call my#GetSnippets('tex','preamble-xeCJK.tex')<CR>
inoremap <buffer> :cw<tab>      <Esc>:call my#GetSnippets('tex','preamble-cwtex.tex')<CR>
inoremap <buffer> :punct<tab>   <Esc>:call my#GetSnippets('tex','preamble-punct.tex')<CR>
inoremap <buffer> :bib<tab>     <Esc>:call my#GetSnippets('tex','preamble-biblatex.tex')<CR>
inoremap <buffer> :tit<tab>     <Esc>:call my#GetSnippets('tex','preamble-title.tex')<CR>
inoremap <buffer> :chenum<tab>  <Esc>:call my#GetSnippets('tex','preamble-chineseenumerate.tex')<CR>
inoremap <buffer> :chnum<tab>   <Esc>:call my#GetSnippets('tex','preamble-chinesenumber.tex')<CR>
inoremap <buffer> :color<tab>   <Esc>:call my#GetSnippets('tex','preamble-color.tex')<CR>
inoremap <buffer> :csv<tab>     <Esc>:call my#GetSnippets('tex','preamble-csv.tex')<CR>
inoremap <buffer> :cols<tab>    <Esc>:call my#GetSnippets('tex','preamble-column.tex')<CR>
inoremap <buffer> :ct<tab>      <Esc>:call my#GetSnippets('tex','preamble-customtitle.tex')<CR>
inoremap <buffer> :enum<tab>    <Esc>:call my#GetSnippets('tex','preamble-enumerate.tex')<CR>
inoremap <buffer> :faux<tab>    <Esc>:call my#GetSnippets('tex','preamble-fauxsc.tex')<CR>
inoremap <buffer> :fig<tab>     <Esc>:call my#GetSnippets('tex','preamble-graphics.tex')<CR>
inoremap <buffer> :foot<tab>    <Esc>:call my#GetSnippets('tex','preamble-footnote.tex')<CR>
inoremap <buffer> :font<tab>    <Esc>:call my#GetSnippets('tex','preamble-font.tex')<CR>
inoremap <buffer> :german<tab>  <Esc>:call my#GetSnippets('tex','preamble-german.tex')<CR>
inoremap <buffer> :hyper<tab>   <Esc>:call my#GetSnippets('tex','preamble-hyperreference.tex')<CR>
inoremap <buffer> :lof<tab>     <Esc>:call my#GetSnippets('tex','preamble-listoffigures.tex')<CR>
inoremap <buffer> :math<tab>    <Esc>:call my#GetSnippets('tex','preamble-math.tex')<CR>
inoremap <buffer> :mn<tab>      <Esc>:call my#GetSnippets('tex','preamble-mathnotes.tex')<CR>
inoremap <buffer> :ow<tab>      <Esc>:call my#GetSnippets('tex','preamble-noorphanwidow.tex')<CR>
inoremap <buffer> :problem<tab> <Esc>:call my#GetSnippets('tex','preamble-problem.tex')<CR>
inoremap <buffer> :prob<tab>    <Esc>:call my#GetSnippets('tex','preamble-mathprob.tex')<CR>
inoremap <buffer> :pagec<tab>   <Esc>:call my#GetSnippets('tex','preamble-pagechinese.tex')<CR>
inoremap <buffer> :pagee<tab>   <Esc>:call my#GetSnippets('tex','preamble-pageenglish.tex')<CR>
inoremap <buffer> :pageg<tab>   <Esc>:call my#GetSnippets('tex','preamble-pagegerman.tex')<CR>
inoremap <buffer> :pageb<tab>   <Esc>:call my#GetSnippets('tex','preamble-pagebeamer.tex')<CR>
inoremap <buffer> :pagep<tab>   <Esc>:call my#GetSnippets('tex','preamble-pageplain.tex')<CR>
inoremap <buffer> :ruby<tab>    <Esc>:call my#GetSnippets('tex','preamble-ruby.tex')<CR>
inoremap <buffer> :tab<tab>     <Esc>:call my#GetSnippets('tex','preamble-table.tex')<CR>
inoremap <buffer> :secf<tab>    <Esc>:call my#GetSnippets('tex','preamble-sectionfont.tex')<CR>
inoremap <buffer> :set<tab>     <Esc>:call my#GetSnippets('tex','preamble-package.tex')<CR>
inoremap <buffer> :shrug<tab>   <Esc>:call my#GetSnippets('tex','preamble-shruggie.tex')<CR>
inoremap <buffer> :sign<tab>    <Esc>:call my#GetSnippets('tex','preamble-sign.tex')<CR>
inoremap <buffer> :tikz<tab>    <Esc>:call my#GetSnippets('tex','preamble-tikz.tex')<CR>
inoremap <buffer> :toc<tab>     <Esc>:call my#GetSnippets('tex','preamble-tableofcontents.tex')<CR>
inoremap <buffer> :udxe<tab>    <Esc>:call my#GetSnippets('tex','preamble-underdotxe.tex')<CR>
inoremap <buffer> :udcw<tab>    <Esc>:call my#GetSnippets('tex','preamble-underdotcwtex.tex')<CR>
inoremap <buffer> :verb<tab>    <Esc>:call my#GetSnippets('tex','preamble-fancyvrb.tex')<CR>
inoremap <buffer> :blind<tab>   <Esc>:call my#GetSnippets('tex','preamble-blindtext.tex')<CR>
inoremap <buffer> :date<Tab>    <Esc>:call my#GetSnippets('tex','preamble-datetime.tex')<CR>
inoremap <buffer> :dinkus<Tab>  <Esc>:call my#GetSnippets('tex','preamble-dinkus.tex')<CR>
inoremap <buffer> :gloss<Tab>   <Esc>:call my#GetSnippets('tex','preamble-glossaries.tex')<CR>

" TEXT OBJECT: TeX specific objects.
xnoremap <silent><buffer> i$     <Esc>:norm! F$lvt$<CR>
xnoremap <silent><buffer> a$     <Esc>:norm! F$vf$<CR>
onoremap <silent><buffer> i$     :norm! F$lvt$<CR>
onoremap <silent><buffer> a$     :norm! F$vf$<CR>
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
xnoremap <silent><buffer> a<bar> <Esc>:norm! F<bar>vf<bar><CR>
onoremap <silent><buffer> i<bar> :norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> a<bar> :norm! F<bar>vf<bar><CR>
xnoremap <silent><buffer> ia     <Esc>:call my#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
xnoremap <silent><buffer> aa     <Esc>:call my#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> ia          :call my#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> aa          :call my#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>
xnoremap <silent><buffer> iQ     :<C-U>call tex#Quotes("i",1)<CR>
xnoremap <silent><buffer> aQ     :<C-U>call tex#Quotes("a",1)<CR>
onoremap <silent><buffer> iQ     :<C-U>call tex#Quotes("i",1)<CR>
onoremap <silent><buffer> aQ     :<C-U>call tex#Quotes("a",1)<CR>
onoremap <silent><buffer> QQ     :<C-U>call tex#Quotes("q",1)<CR>
xnoremap <silent><buffer> iq     :<C-U>call tex#Quotes("i",0)<CR>
xnoremap <silent><buffer> aq     :<C-U>call tex#Quotes("a",0)<CR>
onoremap <silent><buffer> iq     :<C-U>call tex#Quotes("i",0)<CR>
onoremap <silent><buffer> aq     :<C-U>call tex#Quotes("a",0)<CR>
onoremap <silent><buffer> qq     :<C-U>call tex#Quotes("q",0)<CR>

" MISC: page environments.
inoremap <buffer> \cbreak<Tab>  <C-G>u\vfill\null\columnbreak
inoremap <buffer> \blind<Tab>   <Esc>:call my#GetSnippets('tex','indoc-blindtext.tex')<CR>
inoremap <buffer> \blindzh<Tab> <Esc>:call my#GetSnippets('tex','indoc-blindtext-zh.tex')<CR>
inoremap <buffer> \vi<Tab>      <Esc>:call my#GetSnippets('tex','indoc-verbatiminput.tex')<CR>$i
inoremap <buffer> \mini<Tab>    <Esc>:call my#GetSnippets('tex','indoc-minipage.tex')<CR>
inoremap <buffer> `<Tab>        `'<Left>
inoremap <buffer> ``<Tab>       ``''<Left><Left>

" MATH: math shortcuts.
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
inoremap <buffer> \ma<Tab>         <Esc>:call my#GetSnippets('tex','indoc-matrix.tex')<CR>

" TEXT: text/font modifiers.
inoremap <buffer> \bf<Tab> <C-G>u\textbf{}<Left>
inoremap <buffer> \sf<Tab> <C-G>u\textsf{}<Left>
inoremap <buffer> \tt<Tab> <C-G>u\texttt{}<Left>
inoremap <buffer> \em<Tab> <C-G>u\emph{}<Left>
inoremap <buffer> \it<Tab> <C-G>u\textit{}<Left>
inoremap <buffer> \ud<Tab> <C-G>u\underdot{}<Left>
inoremap <buffer> \bs<Tab> <C-G>u\boldsymbol{}<Left>
inoremap <buffer> \t<Tab>  <C-G>u\text{}<Left>
inoremap <buffer> \v<Tab>  <C-G>u\verb""<Left>
inoremap <buffer> \V<Tab>  <C-G>u\Verb""<Left>
inoremap <buffer> \mb<Tab> <C-G>u\mathbf{}<Left>
inoremap <buffer> \mc<Tab> <C-G>u\mathcal{}<Left>
inoremap <buffer> \ms<Tab> <C-G>u\mathscr{}<Left>
inoremap <buffer> \mf<Tab> <C-G>u\mathsf{}<Left>
inoremap <buffer> \mr<Tab> <C-G>u\mathrm{}<Left>
inoremap <buffer> \bb<Tab> <C-G>u\mathbb{}<Left>

" Environments: expandable environments.
inoremap <buffer> \b<Tab>      <Esc>:call tex#EmptyEnvironment()<CR>
inoremap <buffer> \doc<Tab>    <Esc>:call tex#EmptyEnvironment('document')<CR>
inoremap <buffer> \cols<Tab>   <Esc>:call tex#EmptyEnvironment('multicols','{2}')<CR>
inoremap <buffer> \ali<Tab>    <Esc>:call tex#EmptyEnvironment('aligned')<CR>
inoremap <buffer> \ba<Tab>     <Esc>:call tex#EmptyEnvironment('align*')<CR>o
inoremap <buffer> \ga<Tab>     <Esc>:call tex#EmptyEnvironment('gather*')<CR>o
inoremap <buffer> \eq<Tab>     <Esc>:call tex#EmptyEnvironment('equation*')<CR>
inoremap <buffer> \eqs<Tab>    <Esc>:call tex#EmptyEnvironment('equations*')<CR>
inoremap <buffer> \cases<Tab>  <Esc>:call tex#EmptyEnvironment('cases')<CR>
inoremap <buffer> \mat<Tab>    <Esc>:call tex#EmptyEnvironment('bmatrix')<CR>
inoremap <buffer> \vmat<Tab>   <Esc>:call tex#EmptyEnvironment('vmatrix')<CR>
inoremap <buffer> \btab<Tab>   <Esc>:call my#GetSnippets('tex','indoc-envtable.tex')<CR>
inoremap <buffer> \csv<Tab>    <Esc>:call my#GetSnippets('tex','indoc-envtable-csv.tex',0)<CR>
inoremap <buffer> \bfig<Tab>   <Esc>:call my#GetSnippets('tex','indoc-envfigure.tex')<CR>
inoremap <buffer> \subfig<Tab> <Esc>:call my#GetSnippets('tex','indoc-subfigure.tex')<CR>
inoremap <buffer> \tab<Tab>    <Esc>:call my#GetSnippets('tex','indoc-table.tex')<CR>
inoremap <buffer> \fig<Tab>    <Esc>:call my#GetSnippets('tex','indoc-figure.tex')<CR>
inoremap <buffer> \enum<Tab>   <Esc>:call my#GetSnippets('tex','indoc-enum-pure.tex')<CR>
inoremap <buffer> \enumr<Tab>  <Esc>:call my#GetSnippets('tex','indoc-enum-roman.tex')<CR>
inoremap <buffer> \enuma<Tab>  <Esc>:call my#GetSnippets('tex','indoc-enum-alph.tex')<CR>
inoremap <buffer> \item<Tab>   <Esc>:call my#GetSnippets('tex','indoc-item.tex')<CR>
inoremap <buffer> \iff<Tab>    <Esc>:call my#GetSnippets('tex','indoc-iff-arrow.tex')<CR>
inoremap <buffer> \iffc<Tab>   <Esc>:call my#GetSnippets('tex','indoc-iff-cup.tex')<CR>
inoremap <buffer> \alg<Tab>    <Esc>:call my#GetSnippets('tex','indoc-algorithm.tex')<CR>
