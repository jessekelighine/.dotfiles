" ~/.config/nvim/after/ftplugin/quarto.vim
" ~/.config/nvim/after/ftplugin/quarto.lua
" ~/.config/nvim/lua/cmp/quarto.lua
" ~/.config/nvim/after/ftplugin/r.vim
" ~/.config/nvim/after/plugin/treesitter.lua
" ~/.config/nvim/autoload/quarto_complete.vim
" ~/.config/nvim/autoload/r.vim
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/snippets/quarto/
" ~/.config/nvim/snippets/r/

" SETTINGS:
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

" COMMANDS:
command! -buffer -range   FormatTable '<,'>EasyAlign * /|/
command! -buffer -nargs=0 FillAuthor  call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection call markdown#FindSection()
command! -buffer -nargs=0 -bang View  call markdown#View(<bang>0)
command! -buffer -range   FormatR '<,'>! air-pipe
command! -buffer -range   RFormat '<,'>! air-pipe

" LASTMOD:
let b:lastmod_pattern = '^\(date:\s\{-}' .. "[\"']" .. '\).\{-}\(' .. "[\"']" .. '\)'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)
command! -buffer -nargs=? AutoLastMod call markdown#AutoLastMod(<q-args>)
silent AutoLastMod on

" COMPILE:
function! <SID>Compile(open) abort
	let l:quarto_compile_preview = "quarto preview " .. expand("%")
	let l:quarto_compile_command = l:quarto_compile_preview
	if a:open
		call vimslime#OpenTmux(l:quarto_compile_command)
	else
		call vimslime#CloseTmux("\<C-C>\<C-D>")
	endif
endfunction
command! -buffer -bang -nargs=0 Compile call <SID>Compile(<bang>1)
nnoremap <silent><buffer> <leader><Space> <Cmd>Compile<CR>

" COMPLETETION:
setlocal completefunc=quarto_complete#Labs
setlocal omnifunc=quarto_complete#Bibs
command! -buffer -nargs=0 ShowLabs     call quarto_complete#Show('labs')
command! -buffer -nargs=0 ShowBibs     call quarto_complete#Show('bibs')
command! -buffer -nargs=0 GenerateLabs call quarto_complete#GenerateLabs()
command! -buffer -nargs=0 GenerateBibs call quarto_complete#GenerateBibs()

" R MACROS:
nnoremap <buffer><silent> <leader>;  <Cmd>call funcargs#DeleteFunction('[a-zA-Z]','[a-zA-Z0-9._]')<CR>
nnoremap <buffer><silent> <leader>cc <Cmd>RStop<CR>
inoremap <buffer><silent> %<Tab>     %%<Left>
inoremap <buffer><silent> ^<Tab>     ^()<Left>

" R PIPE:
inoremap <buffer><silent> <S-M><Tab> <Esc>:call r#PipeExpand('Tab')<CR>
inoremap <buffer><silent> <S-M><CR>  <Esc>:call r#PipeExpand('CR')<CR>
command! -buffer -nargs=0 PipeSwitch :let b:r_pipe = b:r_pipe=='%>%' ? '|>' : '%>%' | echom ' Pipe: ' .. b:r_pipe
command! -buffer -nargs=0 PipeAutoDetect call r#PipeAutoDetect() | echom ' Pipe: ' .. b:r_pipe
silent PipeAutoDetect

" MARKDOWN TEXT OBJECTS:
xnoremap <silent><buffer> a* <Esc>:norm! F*vf*<CR>
xnoremap <silent><buffer> i* <Esc>:norm! F*lvt*<CR>
onoremap <silent><buffer> i*      :norm! F*lvt*<CR>
onoremap <silent><buffer> a*      :norm! F*vf*<CR>

" LATEX COMMANDS:
nnoremap <buffer><silent> <leader>, <Cmd>call tex#DelLeftRight()<CR>

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
