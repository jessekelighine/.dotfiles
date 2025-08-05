" ~/.config/nvim/after/ftplugin/markdown.vim
" ~/.config/nvim/after/ftplugin/markdown.lua
" ~/.config/nvim/lua/cmp/markdown.lua
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

" SETTINGS:
setlocal smartindent smarttab expandtab shiftwidth=2 softtabstop=2 tabstop=2

" SURROUND:
let b:surround_98 = "**\r**"
let b:surround_99 = "```\r```"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"

" COMMANDS:
nnoremap <buffer> <leader>p :call markdown#View()<CR>
" command! -buffer -range   FormatTable :'<,'>! pandoc -t commonmark_x
command! -buffer -range   FormatTable '<,'>EasyAlign * /|/
command! -buffer -nargs=0 FillAuthor  call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection call markdown#FindSection()
command! -buffer -nargs=0 -bang View  call markdown#View(<bang>0)

" LASTMOD:
let b:lastmod_pattern = '^\(date:\s\{-}' .. "[\"']" .. '\)' .. '.\{-}' .. '\(' .. "[\"']" .. '\)'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)
command! -buffer -nargs=? AutoLastMod call markdown#AutoLastMod(<q-args>)
silent! AutoLastMod on

" COMPILER:
function! <SID>Compile(open) abort
	let l:pandoc_command_css_file = "~/.config/nvim/snippets/markdown/style.css"
	let l:pandoc_command_plain = join([
				\ "pandoc",
				\ "--from markdown+east_asian_line_breaks",
				\ "--css", l:pandoc_command_css_file,
				\ "--mathjax",
				\ "--standalone",
				\ expand("%"),
				\ "--output", expand("%:r") .. ".html"
				\ ])
	let l:pandoc_command_nonumber = l:pandoc_command_plain .. " --toc"
	let l:pandoc_command_number   = l:pandoc_command_nonumber .. " --number-sections"
	let l:pandoc_tmux_command = "echo . | whenever " .. (
				\ file_readable("Makefile")
				\ ? "make"
				\ : l:pandoc_command_plain
				\ )
	if a:open
		call vimslime#OpenTmux(l:pandoc_tmux_command)
	else
		call vimslime#CloseTmux()
	endif
endfunction
command! -buffer -bang -nargs=0 Compile call <SID>Compile(<bang>1)
nnoremap <silent><buffer> <leader>rq      <Cmd>Compile!<CR>
nnoremap <silent><buffer> <leader>rf      <Cmd>Compile<CR>
nnoremap <silent><buffer> <leader><Space> <Cmd>Compile<CR>
nnoremap <silent><buffer> <leader>c       :call markdown#ClearCodeSyntax()<CR>

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
