" ~/.config/nvim/ftplugin/tex.vim
" ~/.config/nvim/syntax/tex.vim
" ~/.config/nvim/snippets/tex/
" ~/.config/nvim/after/indent/tex.vim
" ~/.config/nvim/pack/lang/opt/tex/
" ~/.config/nvim/autoload/tex.vim
" ~/.config/nvim/autoload/textoggle.vim
" ~/.config/nvim/autoload/texcomplete.vim

" SETTINGS: fast syntax, comment, spell, indent environment.
packadd  matchit
setlocal synmaxcol=200
setlocal commentstring=%\ %s
setlocal spellfile=~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/latex.utf-8.add
setlocal foldmethod=manual
setlocal foldnestmax=1
let g:tex_noindent_env='document\|verbatim\|lstlisting\|multicols\|letter'
let g:tex_indent_brace=0

" SURROUND: surround settings.
let b:surround_indent=1
let b:surround_66 ="\\Big\r\\Big"
let b:surround_98 ="\\big\r\\big"
let b:surround_99 ="\\\1--> Command: \1{\r}"
let b:surround_67 ="\\left\\{\r\\right."
let b:surround_81 ="``\r''"
let b:surround_113="`\r'"
let b:surround_101="\\begin{\1--> Environment name: \1}\r\\end{\1\1}"
let b:surround_108="\\left\r\\right"
let b:surround_103="($\r$)"

" FUNCTION KEYS:
nnoremap <silent><buffer> <F1> :tabnew ~/.config/nvim/ftplugin/tex.vim<CR>
nnoremap <silent><buffer> <F2> :tabnew ~/.config/nvim/syntax/tex.vim<CR>
nnoremap <silent><buffer> <F6> :call tex#Compile('xelatex',(has("nvim")?'termopen':'!'))<CR>

" UTILITIES: utilities.
command! -buffer -nargs=0 LastMod      :call my#LastMod('^\(%* *Last Modified: *\)[^ ]*',7)
command! -buffer -nargs=0 ReloadTeX    :call textoggle#Reload()
command! -buffer -nargs=0 ShowToggles  :call textoggle#Show()
command! -buffer -nargs=0 ClearToggles :call textoggle#Clear()
command! -buffer -nargs=0 FindSection  :call tex#FindSection()
command! -buffer -nargs=0 JunkRemove   :! latexmk -C %:r
command! -buffer -nargs=? -bang ContiCompi :call tex#ContiCompi(<bang>0,<f-args>) " args: pdflatex, pdfxe
nnoremap <buffer><silent> <leader><Space> :call tex#ContiCompi(exists('b:tex_conticompi_bufnr'))<CR>
nnoremap <buffer><silent> <leader>c :call tex#EnvironmentChange()<CR>
nnoremap <buffer><silent> <leader>d :call tex#EnvironmentDelete()<CR>
nnoremap <buffer><silent> <leader>, :call tex#DelLeftRight()<CR>
nnoremap <buffer><silent> <leader>8 :call tex#EnvironmentStar()<CR>
nnoremap <buffer><silent> <leader>t :call textoggle#Master()<CR>
nnoremap <buffer><silent> <leader>; :call my#DelFuncCall('\\','[a-zA-Z]','{}')<CR>
nnoremap <buffer><silent> <leader>p :! open %:r.pdf<CR><CR>

" COMPLETETION: `Lables` and `Biblography` complete settings.
setlocal completefunc=texcomplete#Labs
setlocal omnifunc=texcomplete#Bibs
command! -buffer -nargs=0 ShowLabs     :call texcomplete#Show('labs')
command! -buffer -nargs=0 ShowBibs     :call texcomplete#Show('bibs')
command! -buffer -nargs=0 GenerateLabs :call texcomplete#GenerateLabs()
command! -buffer -nargs=0 GenerateBibs :call texcomplete#GenerateBibs()
command! -buffer -nargs=1 SetLabsFiles :call texcomplete#SetFiles('labs',<args>)
command! -buffer -nargs=1 SetBibsFiles :call texcomplete#SetFiles('bibs',<args>)

" PREAMBLES: stored in "snippets/tex".
inoremap <buffer> :qui<tab>     <Esc>:call my#GetSnippets('tex','skeleton.tex')<CR>
inoremap <buffer> :letter<tab>  <Esc>:call my#GetSnippets('tex','skeleton_letter.tex')<CR>
inoremap <buffer> :beamer<tab>  <Esc>:call my#GetSnippets('tex','preamble_beamer.tex')<CR>
inoremap <buffer> :std<tab>     <Esc>:call my#GetSnippets('tex','preamble_standalone.tex')<CR>
inoremap <buffer> :cjk<tab>     <Esc>:call my#GetSnippets('tex','preamble_xeCJK.tex')<CR>
inoremap <buffer> :cw<tab>      <Esc>:call my#GetSnippets('tex','preamble_cwtex.tex')<CR>
inoremap <buffer> :punct<tab>   <Esc>:call my#GetSnippets('tex','preamble_punct.tex')<CR>
inoremap <buffer> :bib<tab>     <Esc>:call my#GetSnippets('tex','preamble_biblatex.tex')<CR>
inoremap <buffer> :tit<tab>     <Esc>:call my#GetSnippets('tex','preamble_title.tex')<CR>
inoremap <buffer> :chenum<tab>  <Esc>:call my#GetSnippets('tex','preamble_chineseenumerate.tex')<CR>
inoremap <buffer> :chnum<tab>   <Esc>:call my#GetSnippets('tex','preamble_chinesenumber.tex')<CR>
inoremap <buffer> :color<tab>   <Esc>:call my#GetSnippets('tex','preamble_color.tex')<CR>
inoremap <buffer> :csv<tab>     <Esc>:call my#GetSnippets('tex','preamble_csv.tex')<CR>
inoremap <buffer> :cols<tab>    <Esc>:call my#GetSnippets('tex','preamble_column.tex')<CR>
inoremap <buffer> :ct<tab>      <Esc>:call my#GetSnippets('tex','preamble_customtitle.tex')<CR>
inoremap <buffer> :enum<tab>    <Esc>:call my#GetSnippets('tex','preamble_enumerate.tex')<CR>
inoremap <buffer> :faux<tab>    <Esc>:call my#GetSnippets('tex','preamble_fauxsc.tex')<CR>
inoremap <buffer> :fig<tab>     <Esc>:call my#GetSnippets('tex','preamble_graphics.tex')<CR>
inoremap <buffer> :foot<tab>    <Esc>:call my#GetSnippets('tex','preamble_footnote.tex')<CR>
inoremap <buffer> :font<tab>    <Esc>:call my#GetSnippets('tex','preamble_font.tex')<CR>
inoremap <buffer> :german<tab>  <Esc>:call my#GetSnippets('tex','preamble_german.tex')<CR>
inoremap <buffer> :hyper<tab>   <Esc>:call my#GetSnippets('tex','preamble_hyperreference.tex')<CR>
inoremap <buffer> :lof<tab>     <Esc>:call my#GetSnippets('tex','preamble_listoffigures.tex')<CR>
inoremap <buffer> :math<tab>    <Esc>:call my#GetSnippets('tex','preamble_math.tex')<CR>
inoremap <buffer> :mn<tab>      <Esc>:call my#GetSnippets('tex','preamble_mathnotes.tex')<CR>
inoremap <buffer> :ow<tab>      <Esc>:call my#GetSnippets('tex','preamble_noorphanwidow.tex')<CR>
inoremap <buffer> :problem<tab> <Esc>:call my#GetSnippets('tex','preamble_problem.tex')<CR>
inoremap <buffer> :prob<tab>    <Esc>:call my#GetSnippets('tex','preamble_mathprob.tex')<CR>
inoremap <buffer> :pagec<tab>   <Esc>:call my#GetSnippets('tex','preamble_pagechinese.tex')<CR>
inoremap <buffer> :pagee<tab>   <Esc>:call my#GetSnippets('tex','preamble_pageenglish.tex')<CR>
inoremap <buffer> :pageg<tab>   <Esc>:call my#GetSnippets('tex','preamble_pagegerman.tex')<CR>
inoremap <buffer> :pageb<tab>   <Esc>:call my#GetSnippets('tex','preamble_pagebeamer.tex')<CR>
inoremap <buffer> :pagep<tab>   <Esc>:call my#GetSnippets('tex','preamble_pageplain.tex')<CR>
inoremap <buffer> :ruby<tab>    <Esc>:call my#GetSnippets('tex','preamble_ruby.tex')<CR>
inoremap <buffer> :tab<tab>     <Esc>:call my#GetSnippets('tex','preamble_table.tex')<CR>
inoremap <buffer> :secf<tab>    <Esc>:call my#GetSnippets('tex','preamble_sectionfont.tex')<CR>
inoremap <buffer> :set<tab>     <Esc>:call my#GetSnippets('tex','preamble_package.tex')<CR>
inoremap <buffer> :shrug<tab>   <Esc>:call my#GetSnippets('tex','preamble_shruggie.tex')<CR>
inoremap <buffer> :sign<tab>    <Esc>:call my#GetSnippets('tex','preamble_sign.tex')<CR>
inoremap <buffer> :tikz<tab>    <Esc>:call my#GetSnippets('tex','preamble_tikz.tex')<CR>
inoremap <buffer> :toc<tab>     <Esc>:call my#GetSnippets('tex','preamble_tableofcontents.tex')<CR>
inoremap <buffer> :udxe<tab>    <Esc>:call my#GetSnippets('tex','preamble_underdotxe.tex')<CR>
inoremap <buffer> :udcw<tab>    <Esc>:call my#GetSnippets('tex','preamble_underdotcwtex.tex')<CR>
inoremap <buffer> :verb<tab>    <Esc>:call my#GetSnippets('tex','preamble_fancyvrb.tex')<CR>
inoremap <buffer> :blind<tab>   <Esc>:call my#GetSnippets('tex','preamble_blindtext.tex')<CR>
inoremap <buffer> :date<Tab>    <Esc>:call my#GetSnippets('tex','preamble_datetime.tex')<CR>
inoremap <buffer> :dinkus<Tab>  <Esc>:call my#GetSnippets('tex','preamble_dinkus.tex')<CR>

" TEXT OBJECT: TeX specific objects.
xnoremap <silent><buffer> i$ <Esc>:norm! F$lvt$<CR>
xnoremap <silent><buffer> a$ <Esc>:norm! F$vf$<CR>
onoremap <silent><buffer> i$      :norm! F$lvt$<CR>
onoremap <silent><buffer> a$      :norm! F$vf$<CR>
xnoremap <silent><buffer> i<bar> <Esc>F<bar>lvt<bar>
xnoremap <silent><buffer> a<bar> <Esc>F<bar>vf<bar>
onoremap <silent><buffer> i<bar>      F<bar>lvt<bar>
onoremap <silent><buffer> a<bar>      F<bar>vf<bar>
xnoremap <silent><buffer> as :call tex#GetSection('a')<CR>
xnoremap <silent><buffer> is :call tex#GetSection('i')<CR>
onoremap <silent><buffer> as :call tex#GetSection('a')<CR>
onoremap <silent><buffer> is :call tex#GetSection('i')<CR>
xnoremap <silent><buffer> ia <Esc>:call my#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
xnoremap <silent><buffer> aa <Esc>:call my#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> ia      :call my#SelectArgument("i",'{\<bar>[',']\<bar>}')<CR>
onoremap <silent><buffer> aa      :call my#SelectArgument("a",'{\<bar>[',']\<bar>}')<CR>
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

" MISC: page environments.
inoremap <buffer> \cbreak<Tab>  <C-G>u\vfill\null\columnbreak
inoremap <buffer> \blind<Tab>   <Esc>:call my#GetSnippets('tex','indoc_blindtext.tex')<CR>
inoremap <buffer> \blindzh<Tab> <Esc>:call my#GetSnippets('tex','indoc_blindtext_zh.tex')<CR>
inoremap <buffer> \vi<Tab>      <Esc>:call my#GetSnippets('tex','indoc_verbatiminput.tex')<CR>$i
inoremap <buffer> \mini<Tab>    <Esc>:call my#GetSnippets('tex','indoc_minipage.tex')<CR>
inoremap <buffer> `<Tab>        `'<Left>
inoremap <buffer> ``<Tab>       ``''<Left><Left>

" MATH: math shortcuts.
inoremap <buffer> _<Tab>          <C-G>u_{}<Left>
inoremap <buffer> ^<Tab>          <C-G>u^{}<Left>
inoremap <buffer> $<Tab>          <C-G>u$$<Left>
inoremap <buffer> ]<Tab>          <C-G>u\left[\right]<Esc><S-F>[a
inoremap <buffer> )<Tab>          <C-G>u\left(\right)<Esc><S-F>(a
inoremap <buffer> }<Tab>          <C-G>u\left\{\right\}<Esc><S-F>{a
inoremap <buffer> {{<Tab>         <C-G>u\{\}<Esc><S-F>{a
inoremap <buffer> <bar><Tab>      <C-G>u<bar><bar><Left>
inoremap <buffer> <bar><bar><Tab> <C-G>u\left<bar>\right<bar><Esc>6hi
inoremap <buffer> \ma<Tab>        <Esc>:call my#GetSnippets('tex','indoc_matrix.tex')<CR>

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
inoremap <buffer> \btab<Tab>   <Esc>:call my#GetSnippets('tex','indoc_envtable.tex')<CR>
inoremap <buffer> \csv<Tab>    <Esc>:call my#GetSnippets('tex','indoc_envtable_csv.tex',0)<CR>
inoremap <buffer> \bfig<Tab>   <Esc>:call my#GetSnippets('tex','indoc_envfigure.tex')<CR>
inoremap <buffer> \subfig<Tab> <Esc>:call my#GetSnippets('tex','indoc_subfigure.tex')<CR>
inoremap <buffer> \tab<Tab>    <Esc>:call my#GetSnippets('tex','indoc_table.tex')<CR>
inoremap <buffer> \fig<Tab>    <Esc>:call my#GetSnippets('tex','indoc_figure.tex')<CR>
inoremap <buffer> \enum<Tab>   <Esc>:call my#GetSnippets('tex','indoc_enum_pure.tex')<CR>
inoremap <buffer> \enumr<Tab>  <Esc>:call my#GetSnippets('tex','indoc_enum_roman.tex')<CR>
inoremap <buffer> \enuma<Tab>  <Esc>:call my#GetSnippets('tex','indoc_enum_alph.tex')<CR>
inoremap <buffer> \item<Tab>   <Esc>:call my#GetSnippets('tex','indoc_item.tex')<CR>
inoremap <buffer> \iff<Tab>    <Esc>:call my#GetSnippets('tex','indoc_iff_arrow.tex')<CR>
inoremap <buffer> \iffc<Tab>   <Esc>:call my#GetSnippets('tex','indoc_iff_cup.tex')<CR>
