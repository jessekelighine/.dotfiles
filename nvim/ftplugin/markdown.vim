" ~/.config/nvim/ftplugin/markdown.vim
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}"\).\{-}\("\)',5)
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -range   FormatTable :'<,'>!pandoc -t commonmark_x

" SURROUND: surround settings.
let b:surround_98="**\r**"
let b:surround_99="<!-- \r -->"

" AUTOLOAD: toggles.
" let g:markdown_fenced_languages = [ 'tex' ]
let b:markdown_code_syntax_toggle=0

" COMPILER: types = {number, nonumber, plain}.
nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/ftplugin/markdown.vim<CR>
nnoremap <buffer> <F2>      :tabnew ~/.config/nvim/after/syntax/markdown.vim<CR>
nnoremap <buffer> <F5>      :call markdown#ToHtml("nonumber")<CR><CR>
nnoremap <buffer> <F6>      :call markdown#ToHtml("plain")<CR><CR>
nnoremap <buffer> <leader>c :call markdown#ClearCodeSyntax()<CR>
nnoremap <buffer> <leader>p :! open %:r.html<CR><CR>

" SETUP: snippets, markdown items.
imap <buffer> :qui<Tab>  <esc>:call my#GetSnippets('markdown','skeleton.md')<CR>:LastMod<CR>
imap <buffer> :c<Tab> <C-G>u<!--  --><esc>hhhi
imap <buffer> :e<Tab> <C-G>u\[\]<Left><Left>
imap <buffer> :q<Tab> <C-G>u(**)<Left><Left>
imap <buffer> :t<Tab> <C-G>u<!-- TODO:  --><esc>hhhi

" TAB COMPLETION: tab complete markdown syntax.
inoremap <buffer> _<Tab>  <C-G>u_{}<Left>
inoremap <buffer> ^<Tab>  <C-G>u^{}<Left>
inoremap <buffer> `<Tab>  <C-G>u``<Left>
inoremap <buffer> $<Tab>  <C-G>u$$<Left>
inoremap <buffer> $$<Tab> <C-G>u$$$$<Left><Left>
inoremap <buffer> *<Tab>  <C-G>u**<Left>
inoremap <buffer> **<Tab> <C-G>u****<Left><Left>
