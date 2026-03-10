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
let b:surround_66  = "\\Big\r\\Big"
" let b:surround_98  = "\\big\r\\big"
let b:surround_108 = "\\left\r\\right"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"

" COMMANDS:
nnoremap <buffer> <leader>p :call markdown#View()<CR>
" command! -buffer -range   FormatTable :'<,'>! pandoc -t commonmark_x
command! -buffer -range   FormatTable '<,'>EasyAlign * /|/
command! -buffer -nargs=0 FillAuthor  call markdown#FillAuthor()
command! -buffer -nargs=? FindSection call markdown#FindSection(<q-args>)
command! -buffer -nargs=0 -bang View  call markdown#View(<bang>0)

" LASTMOD:
let b:lastmod_pattern = '^\(date:\s*' .. '\)' .. '.*' .. '\(\)'
command! -buffer -nargs=0 LastMod call lastmod#Update(b:lastmod_pattern)

" COMPILER:
function! <SID>Compile(open) abort
	let l:live_server = "live-server --wait=50 --ignore=" .. expand("%:p")
	let l:pandoc_command_css_file = "~/.config/nvim/snippets/markdown/style.css"
	let l:pandoc_command_plain = join([
				\ "pandoc",
				\ "--from markdown+east_asian_line_breaks",
				\ "--mathjax",
				\ "--standalone",
				\ expand("%"),
				\ "--output", expand("%:r") .. ".html"
				\ ])
	let l:tmux_command = "echo . | whenever " .. (
				\ file_readable("Makefile")
				\ ? "make"
				\ : l:pandoc_command_plain
				\ )
	if file_readable("Makefile")
		let l:command = "make"
	else
		let l:command = l:live_server .. " & " .. l:tmux_command
	endif
	if a:open
		call vimslime#Open("" .. l:command, "-l 30")
	else
		call vimslime#Close()
	endif
endfunction
command! -buffer -bang -nargs=0 Compile call <SID>Compile(<bang>1)
nnoremap <silent><buffer> <leader>rq      <Cmd>Compile!<CR>
nnoremap <silent><buffer> <leader>rf      <Cmd>Compile<CR>
nnoremap <silent><buffer> <leader><Space> <Cmd>Compile<CR>
nnoremap <silent><buffer> <leader>c       :call markdown#ClearCodeSyntax()<CR>

" MARKDOWN TEXT OBJECTS:
xnoremap <silent><buffer> i* <Esc>:norm! F*lvt*<CR>
xnoremap <silent><buffer> a* <Esc>:norm! F*vf*<CR>
onoremap <silent><buffer> i* :norm! F*lvt*<CR>
onoremap <silent><buffer> a* :norm! F*vf*<CR>

" LATEX TEXT OBJECTS:
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
xnoremap <silent><buffer> a<bar> <Esc>:norm! F<bar>vf<bar><CR>
onoremap <silent><buffer> i<bar> :norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> a<bar> :norm! F<bar>vf<bar><CR>
xnoremap <silent><buffer> i$     <Esc>:norm! F$lvt$<CR>
xnoremap <silent><buffer> a$     <Esc>:norm! F$vf$<CR>
onoremap <silent><buffer> i$     :norm! F$lvt$<CR>
onoremap <silent><buffer> a$     :norm! F$vf$<CR>
