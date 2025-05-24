" ~/.config/nvim/after/ftplugin/markdown.vim
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

" SETTINGS:
" let g:markdown_minlines = 100
" let g:markdown_fenced_languages = [ 'r' ]
setlocal smartindent smarttab " expandtab shiftwidth=2 softtabstop=2 tabstop=2

" SURROUND:
let b:surround_98 = "**\r**"
let b:surround_99 = "```\r```"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"

" COMMANDS:
nnoremap <buffer> <leader>p :call markdown#View()<CR>
command! -buffer -range   FormatTable :'<,'>EasyAlign * /|/
" command! -buffer -range   FormatTable :'<,'>! pandoc -t commonmark_x
command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}' .. "[\"']" .. '\).\{-}\(' .. "[\"']" .. '\)')
command! -buffer -nargs=0 FillAuthor  :call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 -bang View  :call markdown#View(<bang>0)
command! -buffer -nargs=? -bang AutoLastMod :call markdown#AutoLastMod(<q-args>, <bang>1)
silent AutoLastMod ON

" COMPILER:
let b:pandoc_command_css_file = "~/.config/nvim/snippets/markdown/style.css"
let b:pandoc_command_plain = join([
			\ "pandoc",
			\ "--from markdown+east_asian_line_breaks",
			\ "--css", b:pandoc_command_css_file,
			\ "--mathjax",
			\ "--standalone",
			\ expand("%"),
			\ "--output", expand("%:r") .. ".html"
			\ ])
let b:pandoc_command_nonumber = b:pandoc_command_plain .. " --toc"
let b:pandoc_command_number   = b:pandoc_command_nonumber .. " --number-sections"
let b:pandoc_tmux_command = file_readable("Makefile")
			\ ? "echo . | whenever make"
			\ : join(["echo", expand("%"), "|", "whenever", b:pandoc_command_plain])
nnoremap <silent><buffer> <leader>rq      :call vimslime#CloseTmux()<CR>
nnoremap <silent><buffer> <leader>rf      :call vimslime#OpenTmux(b:pandoc_tmux_command)<CR>
nnoremap <silent><buffer> <leader><Space> :call vimslime#OpenTmux(b:pandoc_tmux_command)<CR>
nnoremap <silent><buffer> <F5>            :call system(b:pandoc_command_plain)<CR>
nnoremap <silent><buffer> <F6>            :call system(b:pandoc_command_nonumber)<CR>
nnoremap <silent><buffer> <F7>            :call system(b:pandoc_command_number)<CR>
nnoremap <silent><buffer> <leader>c       :call markdown#ClearCodeSyntax()<CR>

" FTPLUGINS AND SYNTAX:
nnoremap <buffer> <F1> :tabnew ~/.config/nvim/after/ftplugin/markdown.vim<CR>
nnoremap <buffer> <F2> :tabnew ~/.config/nvim/after/syntax/markdown.vim<CR>

" SNIPPETS AND TAB COMPLETIONS:
inoremap <buffer> :qui<Tab> <esc>:call my#GetSnippets('markdown','skeleton.md')<CR>:LastMod<CR>:FillAuthor<CR>G
inoremap <buffer> :c<Tab>   <C-G>u<!--  --><esc>hhhi
inoremap <buffer> :e<Tab>   <C-G>u\[\]<Left><Left>
inoremap <buffer> `<Tab>    <C-G>u``<Left>
inoremap <buffer> ``<Tab>   <C-G>u```<CR>```<Esc>O
inoremap <buffer> *<Tab>    <C-G>u**<Left>
inoremap <buffer> **<Tab>   <C-G>u****<Left><Left>
inoremap <buffer> ::<Tab>   <C-G>u:::<CR>:::<Esc>O
inoremap <buffer> $<Tab>    <C-G>u$$<Left>
inoremap <buffer> $$<Tab>   <C-G>u$$$$<Left><Left>
inoremap <buffer> $$<CR>    <C-G>u$$<CR>$$<Esc>O

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

" LATEX:
let b:match_words ..= ','
			\ .. '\\begin\>:\\end\>,'
			\ .. '\\left\>:\\right\>,'
			\ .. '\\bigl\>:\\bigr\>,'
			\ .. '\\Bigl\>:\\Bigr\>,'
			\ .. '\\Biggl\>:\\Biggr\>,'
command! -buffer -nargs=0 TeXScratch :silent execute "norm! :Scratch 8\r:setlocal ft=tex\r"
nnoremap <silent><buffer> <leader>t  :TeXScratch<CR>
xnoremap <silent><buffer> <leader>t  "9y:TeXScratch<CR>"9p:sil keepp g/^$/sil exe 'norm! "_dd'<CR>:let @" = @0<CR>:noh<CR>:echo ''<CR>
