" ~/.config/nvim/after/ftplugin/quarto.vim
" ~/.config/nvim/after/ftplugin/r.vim
" ~/.config/nvim/after/syntax/quarto.vim
" ~/.config/nvim/after/plugin/treesitter.lua
" ~/.config/nvim/autoload/quarto_complete.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/snippets/quarto
" ~/.config/nvim/snippets/r

" Settings:
setlocal commentstring=<!--\ %s\ -->
setlocal winminwidth=1
setlocal smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab
let b:match_words  = '\<tic\>:\<toc\>'
let b:surround_98  = "**\r**"
let b:surround_58  = ":::\r:::"
let b:surround_66  = "\\Big\r\\Big"
let b:surround_108 = "\\left\r\\right"
let b:surround_84  = "timer$tic()\rtimer$toc()"
let b:surround_112 = "pdf(file = \"\")\rdev.off()"
let b:surround_114 = "```{r}\r```"
let b:surround_116 = "tic()\rtoc()"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"
command! -buffer -nargs=0 PipeSwitch :let b:r_pipe = b:r_pipe=='%>%' ? '|>' : '%>%' | echom ' Pipe: ' .. b:r_pipe
command! -buffer -nargs=0 PipeAutoDetect call r#PipeAutoDetect() | echom ' Pipe: ' .. b:r_pipe
command! -buffer -nargs=? -bang AutoLastMod :call markdown#AutoLastMod(<q-args>, <bang>1)
command! -buffer -range   FormatTable :'<,'>EasyAlign * /|/
command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}' .. "[\"']" .. '\).\{-}\(' .. "[\"']" .. '\)')
command! -buffer -nargs=0 FillAuthor  :call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 -bang View  :call markdown#View(<bang>0)
" command! -buffer -range   FormatTable :'<,'>! pandoc -t commonmark_x
silent AutoLastMod on
silent PipeAutoDetect

" COMPILE:
let b:quarto_compile_preview = "quarto preview " .. expand("%")
let b:quarto_compile_command = b:quarto_compile_preview
command! -buffer -bang -nargs=0 Compile if <bang>1 | call vimslime#OpenTmux(b:quarto_compile_command) | else | call vimslime#CloseTmux("\<C-C>\<C-D>") | endif
nnoremap <silent><buffer> <leader><Space> :Compile<CR>

" COMPLETETION:
setlocal completefunc=quarto_complete#Labs
setlocal omnifunc=quarto_complete#Bibs
command! -buffer -nargs=0 ShowLabs     call quarto_complete#Show('labs')
command! -buffer -nargs=0 ShowBibs     call quarto_complete#Show('bibs')
command! -buffer -nargs=0 GenerateLabs call quarto_complete#GenerateLabs()
command! -buffer -nargs=0 GenerateBibs call quarto_complete#GenerateBibs()
" command! -buffer -nargs=1 SetLabsFiles :call texcomplete#SetFiles('labs',<args>)
" command! -buffer -nargs=1 SetBibsFiles :call texcomplete#SetFiles('bibs',<args>)

" MARKDOWN MACROS:
nnoremap <buffer><silent> <F1>      :tabnew ~/.config/nvim/after/ftplugin/quarto.vim<CR>
nnoremap <silent><buffer> <leader>p :call markdown#View()<CR>
inoremap <silent><buffer> :qui<Tab> <Esc>:call snippets#Get('quarto','skeleton.qmd')<CR>:LastMod<CR>:FillAuthor<CR>
inoremap <silent><buffer> :c<Tab>   <C-G>u<!--  --><Esc>hhhi
inoremap <silent><buffer> `<Tab>    <C-G>u``<Left>
inoremap <silent><buffer> ``<Tab>   <C-G>u```{r}<CR>```<Esc>O
inoremap <silent><buffer> *<Tab>    <C-G>u**<Left>
inoremap <silent><buffer> **<Tab>   <C-G>u****<Left><Left>

" R MACROS:
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>
nnoremap <buffer><silent> <leader>cc :RStop<CR>

" R SNIPPETS:
inoremap <buffer> :future<Tab> <Esc>:call snippets#Get("r", "future.R")<CR>
inoremap <buffer> :bl<Tab>     <Esc>:call snippets#Get("r", "block.R")<CR>
inoremap <buffer> :lib<Tab>    <Esc>:call snippets#Get("r", "library.R")<CR>
inoremap <buffer> :ggs<Tab>    <Esc>:call snippets#Get("r", "ggsave.R")<CR>
inoremap <buffer> :ggch<Tab>   <Esc>:call snippets#Get("r", "ggplotChinese.R")<CR>
inoremap <buffer> :se<Tab>     <Esc>:call snippets#Get("r", "robust.R")<CR>
inoremap <buffer> :log<Tab>    <Esc>:call snippets#Get("r", "logfile.R")<CR>
inoremap <buffer> :cl<Tab>     <Esc>:call snippets#Get("r", "consolelog.R")<CR>
inoremap <buffer> :mode<Tab>   <Esc>:call snippets#Get("r", "modus.R")<CR>
inoremap <buffer> :rm<Tab>     <Esc>:call snippets#Get("r", "rm.R")<CR>
inoremap <buffer> :timer<Tab>  <Esc>:call snippets#Get("r", "timer.R")<CR>
inoremap <buffer> :curry<Tab>  <Esc>:call snippets#Get("r", "curry.R")<CR>

" TEXT OBJECTS:
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> i<bar>      :norm! F<bar>lvt<bar><CR>
xnoremap <silent><buffer> a*     <Esc>:norm! F*vf*<CR>
xnoremap <silent><buffer> i*     <Esc>:norm! F*lvt*<CR>
onoremap <silent><buffer> i*          :norm! F*lvt*<CR>
onoremap <silent><buffer> a*          :norm! F*vf*<CR>
xnoremap <silent><buffer> a$     <Esc>:norm! F$vf$<CR>
xnoremap <silent><buffer> i$     <Esc>:norm! F$lvt$<CR>
onoremap <silent><buffer> i$          :norm! F$lvt$<CR>
onoremap <silent><buffer> a$          :norm! F$vf$<CR>

" BLOCKS:
inoremap <buffer><silent> ::<Tab>     <C-G>u:::<Space>{}<CR>:::<Esc><Up>$i

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
inoremap <buffer> $<Tab>    <C-G>u$$<Left>
inoremap <buffer> $$<Tab>   <C-G>u$$$$<Left><Left><CR><Esc>O
inoremap <buffer> $$<CR>    <C-G>u$$<CR>$$<Esc>O

inoremap <buffer> \t<Tab>          <C-G>u\text{}<Left>
inoremap <buffer> \bs<Tab>         <C-G>u\boldsymbol{}<Left>
inoremap <buffer> \bb<Tab>         <C-G>u\mathbb{}<Left>
inoremap <buffer> \mb<Tab>         <C-G>u\mathbold{}<Left>
inoremap <buffer> \mc<Tab>         <C-G>u\mathcal{}<Left>
inoremap <buffer> \ms<Tab>         <C-G>u\mathscr{}<Left>
inoremap <buffer> \mf<Tab>         <C-G>u\mathsf{}<Left>
inoremap <buffer> \mt<Tab>         <C-G>u\mathtt{}<Left>
inoremap <buffer> \mr<Tab>         <C-G>u\mathrm{}<Left>
inoremap <buffer> \mk<Tab>         <C-G>u\mathfrak{}<Left>
