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
let b:surround_116 = "tic()\rtoc()"
let b:r_pipe_type  = "|>"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"
command! -buffer -nargs=0 PipeSwitch :let b:r_pipe_type = b:r_pipe_type=='%>%' ? '|>' : '%>%' | echom ' Pipe: ' .. b:r_pipe_type
command! -buffer -nargs=? -bang AutoLastMod :call markdown#AutoLastMod(<q-args>, <bang>1)
command! -buffer -range   FormatTable :'<,'>EasyAlign * /|/
command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}' .. "[\"']" .. '\).\{-}\(' .. "[\"']" .. '\)')
command! -buffer -nargs=0 FillAuthor  :call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 -bang View  :call markdown#View(<bang>0)
" command! -buffer -range   FormatTable :'<,'>! pandoc -t commonmark_x
silent AutoLastMod ON

" COMPILE:
let b:quarto_compile_preview = "quarto preview " .. expand("%")
let b:quarto_compile_command = b:quarto_compile_preview
nnoremap <silent><buffer> <leader><Space> <Cmd>call vimslime#OpenTmux(b:quarto_compile_command)<CR>

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
inoremap <silent><buffer> :qui<Tab> <Esc>:call my#GetSnippets('quarto','skeleton.qmd')<CR>:LastMod<CR>:FillAuthor<CR>
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
inoremap <buffer> :future<Tab> <Esc>:call my#GetSnippets("r", "future.R")<CR>
inoremap <buffer> :bl<Tab>     <Esc>:call my#GetSnippets("r", "block.R")<CR>
inoremap <buffer> :lib<Tab>    <Esc>:call my#GetSnippets("r", "library.R")<CR>
inoremap <buffer> :ggs<Tab>    <Esc>:call my#GetSnippets("r", "ggsave.R")<CR>
inoremap <buffer> :ggch<Tab>   <Esc>:call my#GetSnippets("r", "ggplotChinese.R")<CR>
inoremap <buffer> :se<Tab>     <Esc>:call my#GetSnippets("r", "robust.R")<CR>
inoremap <buffer> :log<Tab>    <Esc>:call my#GetSnippets("r", "logfile.R")<CR>
inoremap <buffer> :cl<Tab>     <Esc>:call my#GetSnippets("r", "consolelog.R")<CR>
inoremap <buffer> :mode<Tab>   <Esc>:call my#GetSnippets("r", "modus.R")<CR>
inoremap <buffer> :rm<Tab>     <Esc>:call my#GetSnippets("r", "rm.R")<CR>
inoremap <buffer> :timer<Tab>  <Esc>:call my#GetSnippets("r", "timer.R")<CR>
inoremap <buffer> :curry<Tab>  <Esc>:call my#GetSnippets("r", "curry.R")<CR>

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
inoremap <buffer> \mb<Tab> <C-G>u\mathbf{}<Left>
inoremap <buffer> \mc<Tab> <C-G>u\mathcal{}<Left>
inoremap <buffer> \ms<Tab> <C-G>u\mathscr{}<Left>
inoremap <buffer> \mf<Tab> <C-G>u\mathsf{}<Left>
inoremap <buffer> \mt<Tab> <C-G>u\mathtt{}<Left>
inoremap <buffer> \mr<Tab> <C-G>u\mathrm{}<Left>
inoremap <buffer> \bb<Tab> <C-G>u\mathbb{}<Left>
inoremap <buffer> \t<Tab>  <C-G>u\text{}<Left>
inoremap <buffer> $<Tab>    <C-G>u$$<Left>
inoremap <buffer> $$<Tab>   <C-G>u$$$$<Left><Left><CR><Esc>O
inoremap <buffer> $$<CR>    <C-G>u$$<CR>$$<Esc>O

" BLOCKS:
inoremap <buffer><silent> ::<Tab>     <C-G>u:::<Space>{}<CR>:::<Esc><Up>$i
inoremap <buffer><silent> ::tip<Tab>  <C-G>u:::<Space>{.callout-tip}<CR>:::<Esc>O
inoremap <buffer><silent> ::note<Tab> <C-G>u:::<Space>{.callout-note}<CR>:::<Esc>O
inoremap <buffer><silent> ::warn<Tab> <C-G>u:::<Space>{.callout-warning}<CR>:::<Esc>O
inoremap <buffer><silent> ::imp<Tab>  <C-G>u:::<Space>{.callout-important}<CR>:::<Esc>O
inoremap <buffer><silent> ::cau<Tab>  <C-G>u:::<Space>{.callout-caution}<CR>:::<Esc>O
inoremap <buffer><silent> ::def<Tab>  <C-G>u:::<Space>{#def- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::thm<Tab>  <C-G>u:::<Space>{#thm- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::lem<Tab>  <C-G>u:::<Space>{#lem- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::cor<Tab>  <C-G>u:::<Space>{#cor- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::pro<Tab>  <C-G>u:::<Space>{#prp- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::rem<Tab>  <C-G>u:::<Space>{#rem- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::fig<Tab>  <C-G>u:::<Space>{#fig- fig-env="figure*"}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::tab<Tab>  <C-G>u:::<Space>{#tbl-}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::eg<Tab>   <C-G>u:::<Space>{#exm- name=""}<CR>:::<Esc><Up>$F-a
inoremap <buffer><silent> ::pf<Tab>   <C-G>u:::<Space>{.proof}<CR>:::<Esc>O
" inoremap <buffer><silent> ::exr<Tab>  <C-G>u:::{#exr- name=""}<CR>:::<Esc><Up>$F-a
" inoremap <buffer><silent> ::sol<Tab>  <C-G>u:::{#sol- name=""}<CR>:::<Esc><Up>$F-a
" inoremap <buffer><silent> ::cnj<Tab>  <C-G>u:::{#cnj- name=""}<CR>:::<Esc><Up>$F-a
