" ~/.config/nvim/after/ftplugin/rmd.vim
" ~/.config/nvim/snippets/rmd/

" Surround:
" let b:surround_114 = "```{r}\r```"

setlocal smartindent expandtab shiftwidth=2 softtabstop=2 tabstop=2 smarttab

command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 FillAuthor  :call markdown#FillAuthor()

" LASTMOD:
let b:lastmod_pattern = '^\(date:\s\{-}' .. "[\"']" .. '\).\{-}\(' .. "[\"']" .. '\)'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)
command! -buffer -nargs=? AutoLastMod call markdown#AutoLastMod(<q-args>)
silent AutoLastMod on

let b:rmarkdown_knit_command = "echo . | whenever make"
nnoremap <silent><buffer> <leader><Space> :call vimslime#OpenTmux(b:rmarkdown_knit_command)<CR>

" SNIPPET:
inoremap <buffer> :qui<Tab> <Esc>:call snippet#Get('rmd','skeleton.Rmd')<CR>:LastMod<CR>:FillAuthor<CR>G

" Mappings:
inoremap <buffer> :c<Tab>   <C-G>u<!--  --><esc>hhhi
inoremap <buffer> :e<Tab>   <C-G>u\[\]<Left><Left>
inoremap <buffer> `<Tab>    <C-G>u``<Left>
inoremap <buffer> *<Tab>    <C-G>u**<Left>
inoremap <buffer> **<Tab>   <C-G>u****<Left><Left>
inoremap <buffer> ::<Tab>   <C-G>u:::<CR>:::<Esc>O
inoremap <buffer> $<Tab>    <C-G>u$$<Left>
inoremap <buffer> $$<Tab>   <C-G>u$$$$<Left><Left>
inoremap <buffer> $$<CR>    <C-G>u$$<CR>$$<Esc>O
inoremap <buffer> ``<Tab>   <C-G>u```{r}<Enter>```<esc><S-O>

inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
nnoremap <buffer><silent> <leader>;  :call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>

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
