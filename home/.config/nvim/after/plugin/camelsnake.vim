" ~/.config/nvim/after/plugin/camelsnake.vim
" ~/.config/nvim/autoload/camelsnake.vim

function! <SID>Snakify() abort
	let l:pos = getpos(".")
	execute "keeppatterns '<,'>" .. 's/\%V.*\%V./\=camelsnake#Snakify(submatch(0))/'
	call setpos(".", l:pos)
endfunction

function! <SID>Camelize() abort
	let l:pos = getpos(".")
	execute "keeppatterns '<,'>" .. 's/\%V.*\%V./\=camelsnake#Camelize(submatch(0))/'
	call setpos(".", l:pos)
endfunction

command! -range Snakify  call <SID>Snakify()
command! -range Camelize call <SID>Camelize()
