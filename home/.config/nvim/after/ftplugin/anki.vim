" ~/.config/nvim/after/ftplugin/anki.vim

syntax match  AnkiStichwort '^[^\t]\+'
syntax match  AnkiDiv       '</*.\{-}>' contains=@NoSpell
syntax match  AnkiElement   '&.\{-};'   contains=@NoSpell
syntax match  AnkiBreak     '<br>'      contains=@NoSpell
syntax region AnkiArten matchgroup=AnkiNein start="\t" end=" " contains=@NoSpell

highlight def link AnkiStichwort Yellow
highlight def link AnkiDiv       Purple
highlight def link AnkiElement   Orange
highlight def link AnkiBreak     Green
highlight def link AnkiArten     Red
highlight def link AnkiNein      Deliminator

command -buffer -nargs=0 StichwoeterAnordnen :call <SID>StichwoeterAnordnen()
function! <SID>StichwoeterAnordnen()
	" let l:wortarten = ['m', 'f', 'mf', 'n', 'v', 'a', 'con', 'pron', 'pl', 'i'] " german
	let l:wortarten = ['n', 'v', 'a', 'ad'] " english
	for l:type in l:wortarten
		silent exe 'norm :g/^.\+\t\zs'.l:type.'\.\ze /m$'."\<CR>o\<Esc>"
	endfor
	silent exe 'norm gg'
	let l:count = 0
	while l:count < len( l:wortarten )
		silent exe "norm vip:sort\<CR>}j"
		let l:count += 1
	endwhile
	%s/^$\n//g
	silent exe 'norm ddgg'
	redraw | echom '--> Stichwörter nach Wortarten angeordnet.'
endfunction

set  list
call my#TabSize(30)
call my#ChineseSpelling(0) " english
" call my#ChineseSpelling(1) " german
setl spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/anki.utf-8.add

nnoremap <buffer><silent> <F1>                    :tabnew ~/.config/nvim/after/ftplugin/anki.vim<CR>
inoremap <buffer><silent> .<Tab>                  .<br>:<Space>
inoremap <buffer><silent> <<Tab>                  <br>:<Space>
" nnoremap <buffer><silent> <Plug>(ChineseSpelling) :call my#ChineseSpelling(1)<CR>
