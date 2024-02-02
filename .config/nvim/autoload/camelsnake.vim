" ~/.config/nvim/autoload/camelsnake.vim

" Test: CamelSnake --> camel_snake
" Test: camelSnake --> camel_snake
function! camelsnake#Snakify(name)
	let l:name = substitute(a:name, '\u', '_\l&', 'g')
	let l:name = l:name[0]=='_' ? strpart(l:name,1,strlen(l:name)) : l:name
	return l:name
endfunction

" Test: camel_snake --> CamelSnake
function! camelsnake#Camelize(name)
	let l:name = substitute(a:name, '_\([^_]\)', '\u\1', 'g')
	let l:name = l:name[0]!=#'\u' ? toupper(l:name[0]).strpart(l:name,1,strlen(l:name)) : l:name
	return l:name
endfunction
