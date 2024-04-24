" ~/.config/nvim/ftplugin/markdown.vim
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/pack/main/opt/markdown-preview.nvim/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

nnoremap <buffer> <F1> :tabnew ~/.config/nvim/ftplugin/markdown.vim<CR>
nnoremap <buffer> <F2> :tabnew ~/.config/nvim/after/syntax/markdown.vim<CR>

command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}"\).\{-}\("\)',min([line("$"),5]))
command! -buffer -nargs=0 FillAuthor  :call markdown#FillAuthor()
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 TexScratch  :silent exec "norm! :Scratch\r:setl ft=tex\ra\\[\r\r\\]\ek"
command! -buffer -range   FormatTable :'<,'>!pandoc -t commonmark_x

" SURROUND: surround settings.
let b:surround_98="**\r**"
let b:surround_99="<!-- \r -->"
let b:surround_101 = "\\begin{\1--> Environment name: \1}\r\\end{\1\1}"

" AUTOLOAD: toggles.
let g:markdown_fenced_languages = [ 'r' ]
" let g:markdown_minlines = 100
let b:markdown_code_syntax_toggle=0

" VIEW:
let b:markdown_view_file = file_readable(expand("%:p:r") .. ".html")
			\ ? expand("%:p:r") .. ".html"
			\ : expand("%:p")
nnoremap <buffer> <leader>p :call markdown#View()<CR>
command! -buffer -nargs=0 View :call markdown#View(1)

" COMPILER:
packadd! vim-slime
let b:pandoc_command_css_file = "~/.config/nvim/snippets/markdown/style.css"
let b:pandoc_command_plain = join([
			\ "pandoc",
			\ "--from markdown+east_asian_line_breaks",
			\ "--css", b:pandoc_command_css_file,
			\ "--mathjax",
			\ "--standalone",
			\ expand("%:p"),
			\ "--output", expand("%:p:r") .. ".html"
			\ ])
let b:pandoc_command_nonumber = b:pandoc_command_plain .. " --toc"
let b:pandoc_command_number   = b:pandoc_command_nonumber .. " --number-sections"
let b:pandoc_tmux_command = file_readable("Makefile")
			\ ? "make ; whenever . make"
			\ : join(["whenever", expand("%:p"), b:pandoc_command_plain])
nnoremap <silent><buffer> <leader>rq      :call vimslime#CloseTmux()<CR>
nnoremap <silent><buffer> <leader>rf      :call vimslime#OpenTmux(b:pandoc_tmux_command)<CR>
nnoremap <silent><buffer> <leader><Space> :call vimslime#OpenTmux(b:pandoc_tmux_command)<CR>
nnoremap <buffer> <F5> :call system(b:pandoc_command_plain)<CR>
nnoremap <buffer> <F6> :call system(b:pandoc_command_nonumber)<CR>
nnoremap <buffer> <F7> :call system(b:pandoc_command_number)<CR>
nnoremap <buffer> <leader>c :call markdown#ClearCodeSyntax()<CR>

" SETUP: snippets, markdown items.
imap <silent><buffer> :qui<Tab> <esc>:call my#GetSnippets('markdown','skeleton.md')<CR>:LastMod<CR>:FillAuthor<CR>G
imap <silent><buffer> :c<Tab>   <C-G>u<!--  --><esc>hhhi
imap <silent><buffer> :e<Tab>   <C-G>u\[\]<Left><Left>
imap <silent><buffer> :q<Tab>   <C-G>u(**)<Left><Left>
imap <silent><buffer> :t<Tab>   <C-G>u<!-- TODO:  --><esc>hhhi

" TAB COMPLETION: tab complete markdown syntax.
inoremap <buffer> `<Tab>   <C-G>u``<Left>
inoremap <buffer> ``<Tab>  <C-G>u```<CR>```<Esc>O
inoremap <buffer> *<Tab>   <C-G>u**<Left>
inoremap <buffer> **<Tab>  <C-G>u****<Left><Left>
inoremap <buffer> ::<Tab>  <C-G>u:::<CR>:::<Esc>O

" TABLE: Commands
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> i<bar>      :norm! F<bar>lvt<bar><CR>

" LATEX: LaTeX
" let b:surround_66 ="\\Big\r\\Big"
" let b:surround_98 ="\\big\r\\big"
let b:surround_108="\\left\r\\right"
nnoremap <silent><buffer> <leader>t        :TexScratch<CR>:call feedkeys("a")<CR>
xnoremap <silent><buffer> a$               <Esc>:norm! F$vf$<CR>
xnoremap <silent><buffer> i$               <Esc>:norm! F$lvt$<CR>
onoremap <silent><buffer> i$               :norm! F$lvt$<CR>
onoremap <silent><buffer> a$               :norm! F$vf$<CR>
xnoremap <silent><buffer> a*               <Esc>:norm! F*vf*<CR>
xnoremap <silent><buffer> i*               <Esc>:norm! F*lvt*<CR>
onoremap <silent><buffer> i*               :norm! F*lvt*<CR>
onoremap <silent><buffer> a*               :norm! F*vf*<CR>
inoremap <silent><buffer> $<Tab>           <C-G>u$$<Left>
inoremap <silent><buffer> $$<Tab>          <C-G>u$$$$<Left><Left>
inoremap <silent><buffer> $$<CR>           <C-G>u$$$$<Left><Left><CR><Esc>O
inoremap <silent><buffer> _<Tab>           <C-G>u_{}<Left>
inoremap <silent><buffer> ^<Tab>           <C-G>u^{}<Left>
inoremap <silent><buffer> \t<Tab>          \text{}<Left>
inoremap <silent><buffer> ]<Tab>           <C-G>u\left[\right]<Esc><S-F>[a
inoremap <silent><buffer> )<Tab>           <C-G>u\left(\right)<Esc><S-F>(a
inoremap <silent><buffer> }<Tab>           <C-G>u\left\{\right\}<Esc><S-F>{a
inoremap <silent><buffer> {{<Tab>          <C-G>u\{\}<Esc><S-F>{a
inoremap <silent><buffer> <bar><Tab>       <C-G>u<bar><bar><Left>
inoremap <silent><buffer> <bar><bar><Tab>  <C-G>u\left<bar>\right<bar><Esc>6hi
inoremap <silent><buffer> \<bar><Tab>      <C-G>u\<bar>\<bar><Left><Left>
inoremap <silent><buffer> \<bar><bar><Tab> <C-G>u\left\<bar>\right\<bar><Esc>7hi
inoremap <silent><buffer> \bb<Tab>         <C-G>u\mathbb{}<Left>
inoremap <silent><buffer> \bs<Tab>         <C-G>u\boldsymbol{}<Left>
inoremap <silent><buffer> \mb<Tab>         <C-G>u\mathbf{}<Left>
inoremap <silent><buffer> \mc<Tab>         <C-G>u\mathcal{}<Left>
inoremap <silent><buffer> \mf<Tab>         <C-G>u\mathsf{}<Left>
inoremap <silent><buffer> \mr<Tab>         <C-G>u\mathrm{}<Left>
inoremap <silent><buffer> \ms<Tab>         <C-G>u\mathscr{}<Left>
inoremap <silent><buffer> \t<Tab>          <C-G>u\text{}<Left>
inoremap <silent><buffer> \ba<Tab>         <Esc>:call tex#EmptyEnvironment('align*')<CR>o
