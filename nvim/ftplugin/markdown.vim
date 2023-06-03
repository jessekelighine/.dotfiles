" ~/.config/nvim/ftplugin/markdown.vim
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/pack/main/opt/markdown-preview.nvim/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}"\).\{-}\("\)', min([line("$"),5]))
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -nargs=0 View        :call markdown#View(1)
command! -buffer -nargs=? PandocPVC   :call markdown#PandocPVC(<q-args>)
command! -buffer -range   FormatTable :'<,'>!pandoc -t commonmark_x

" SURROUND: surround settings.
let b:surround_98="**\r**"
let b:surround_99="<!-- \r -->"

" AUTOLOAD: toggles.
" let g:markdown_fenced_languages = ['bash']
" let g:markdown_minlines = 100
let b:markdown_code_syntax_toggle=0

" VIEW:
nnoremap <buffer> <leader>p :call markdown#View(0)<CR>

" COMPILER: types = {number, nonumber, plain}.
nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/ftplugin/markdown.vim<CR>
nnoremap <buffer> <F2>      :tabnew ~/.config/nvim/after/syntax/markdown.vim<CR>
nnoremap <buffer> <F5>      :call markdown#ToHtml("plain")<CR><CR>
nnoremap <buffer> <F6>      :call markdown#ToHtml("nonumber")<CR><CR>
nnoremap <buffer> <F7>      :call markdown#ToHtml("number")<CR><CR>
nnoremap <buffer> <leader>c :call markdown#ClearCodeSyntax()<CR>
nnoremap <silent><buffer> <leader><Space> :call markdown#PandocPVC()<CR>

" SETUP: snippets, markdown items.
imap <buffer> :qui<Tab> <esc>:call my#GetSnippets('markdown','skeleton.md')<CR>:LastMod<CR>
imap <buffer> :c<Tab>   <C-G>u<!--  --><esc>hhhi
imap <buffer> :e<Tab>   <C-G>u\[\]<Left><Left>
imap <buffer> :q<Tab>   <C-G>u(**)<Left><Left>
imap <buffer> :t<Tab>   <C-G>u<!-- TODO:  --><esc>hhhi

" TAB COMPLETION: tab complete markdown syntax.
inoremap <buffer> `<Tab>  <C-G>u``<Left>
inoremap <buffer> *<Tab>  <C-G>u**<Left>
inoremap <buffer> **<Tab> <C-G>u****<Left><Left>

" TABLE: Commands
xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> i<bar>      :norm! F<bar>lvt<bar><CR>

" LATEX: LaTeX
let b:surround_66 ="\\Big\r\\Big"
let b:surround_98 ="\\big\r\\big"
let b:surround_108="\\left\r\\right"
xnoremap <silent><buffer> a$      <Esc>:norm! F$vf$<CR>
xnoremap <silent><buffer> i$      <Esc>:norm! F$lvt$<CR>
onoremap <silent><buffer> i$           :norm! F$lvt$<CR>
onoremap <silent><buffer> a$           :norm! F$vf$<CR>
inoremap <silent><buffer> $<Tab>  <C-G>u$$<Left>
inoremap <silent><buffer> $$<Tab> <C-G>u$$$$<Left><Left>
inoremap <silent><buffer> $$<CR>  <C-G>u$$$$<Left><Left><CR><Esc>O
inoremap <silent><buffer> _<Tab>  <C-G>u_{}<Left>
inoremap <silent><buffer> ^<Tab>  <C-G>u^{}<Left>
inoremap <silent><buffer> \t<Tab> \text{}<Left>
inoremap <silent><buffer> ]<Tab>  <C-G>u\left[\right]<Esc><S-F>[a
inoremap <silent><buffer> )<Tab>  <C-G>u\left(\right)<Esc><S-F>(a
inoremap <silent><buffer> }<Tab>  <C-G>u\left\{\right\}<Esc><S-F>{a
inoremap <silent><buffer> {{<Tab> <C-G>u\{\}<Esc><S-F>{a
