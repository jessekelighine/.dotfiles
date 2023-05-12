" ~/.config/nvim/ftplugin/markdown.vim
" ~/.config/nvim/snippets/markdown/
" ~/.config/nvim/pack/main/opt/markdown-preview.nvim/
" ~/.config/nvim/autoload/markdown.vim
" ~/.config/nvim/after/indent/markdown.vim
" ~/.config/nvim/after/syntax/markdown.vim

command! -buffer -nargs=0 LastMod     :call my#LastMod('^\(date:\s\{-}"\).\{-}\("\)', min([line("$"),5]))
command! -buffer -nargs=0 FindSection :call markdown#FindSection()
command! -buffer -range   FormatTable :'<,'>!pandoc -t commonmark_x
command! -buffer -nargs=? PandocPVC   :call markdown#PandocPVC(<q-args>)
command! -buffer -nargs=0 View        :! open -a Firefox %

" PREVIEW: real time preview
packadd markdown-preview.nvim
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_markdown_css = expand('~/.config/nvim/snippets/markdown/style.css')
let g:mkdp_browserfunc = 'markdown#OpenMarkdownPreview'
let g:mkdp_page_title = '${name}'
let g:mkdp_theme = 'light'
let g:mkdp_preview_options = {
	\ 'mkit': {},
	\ 'katex': {},
	\ 'uml': {},
	\ 'maid': {},
	\ 'disable_sync_scroll': 0,
	\ 'sync_scroll_type': 'middle',
	\ 'hide_yaml_meta': 1,
	\ 'sequence_diagrams': {},
	\ 'flowchart_diagrams': {},
	\ 'content_editable': v:false,
	\ 'disable_filename': 1,
	\ 'toc': {}
	\ }

" SURROUND: surround settings.
let b:surround_98="**\r**"
let b:surround_99="<!-- \r -->"

" AUTOLOAD: toggles.
" let g:markdown_fenced_languages = ['bash']
" let g:markdown_minlines = 100
let b:markdown_code_syntax_toggle=0

" COMPILER: types = {number, nonumber, plain}.
nnoremap <buffer> <F1>      :tabnew ~/.config/nvim/ftplugin/markdown.vim<CR>
nnoremap <buffer> <F2>      :tabnew ~/.config/nvim/after/syntax/markdown.vim<CR>
nnoremap <buffer> <F5>      :call markdown#ToHtml("plain")<CR><CR>
nnoremap <buffer> <F6>      :call markdown#ToHtml("nonumber")<CR><CR>
nnoremap <buffer> <F7>      :call markdown#ToHtml("number")<CR><CR>
nnoremap <buffer> <leader>c :call markdown#ClearCodeSyntax()<CR>
nnoremap <buffer> <leader>p :! open %:r.html<CR><CR>
nnoremap <silent><buffer> <leader><Space> :call markdown#PandocPVC()<CR>

" SETUP: snippets, markdown items.
imap <buffer> :qui<Tab> <esc>:call my#GetSnippets('markdown','skeleton.md')<CR>:LastMod<CR>
imap <buffer> :c<Tab>   <C-G>u<!--  --><esc>hhhi
imap <buffer> :e<Tab>   <C-G>u\[\]<Left><Left>
imap <buffer> :q<Tab>   <C-G>u(**)<Left><Left>
imap <buffer> :t<Tab>   <C-G>u<!-- TODO:  --><esc>hhhi

" TAB COMPLETION: tab complete markdown syntax.
inoremap <buffer> _<Tab>  <C-G>u_{}<Left>
inoremap <buffer> ^<Tab>  <C-G>u^{}<Left>
inoremap <buffer> `<Tab>  <C-G>u``<Left>
inoremap <buffer> $<Tab>  <C-G>u$$<Left>
inoremap <buffer> $$<Tab> <C-G>u$$$$<Left><Left>
inoremap <buffer> $$<CR>  <C-G>u$$$$<Left><Left><CR><Esc>O
inoremap <buffer> *<Tab>  <C-G>u**<Left>
inoremap <buffer> **<Tab> <C-G>u****<Left><Left>

xnoremap <silent><buffer> i<bar> <Esc>:norm! F<bar>lvt<bar><CR>
onoremap <silent><buffer> i<bar>      :norm! F<bar>lvt<bar><CR>
xnoremap <silent><buffer> a$     <Esc>:norm! F$vf$<CR>
xnoremap <silent><buffer> i$     <Esc>:norm! F$lvt$<CR>
onoremap <silent><buffer> i$          :norm! F$lvt$<CR>
onoremap <silent><buffer> a$          :norm! F$vf$<CR>
