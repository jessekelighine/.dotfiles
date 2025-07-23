" ~/.config/nvim/autoload/camelsnake.vim
" ~/.config/nvim/after/plugin/camelsnake.vim

" Test: CamelSnake --> camel_snake
" Test: camelSnake --> camel_snake
function! camelsnake#Snakify(name) abort
	let l:name = substitute(a:name, '\u', '_\l&', 'g')
	let l:clean_first_char = l:name[0] == '_'
	return l:clean_first_char ? strpart(l:name, 1, strlen(l:name)) : l:name
endfunction

" Test: camel_snake --> CamelSnake
function! camelsnake#Camelize(name) abort
	let l:name = substitute(a:name, '_\([^_]\)', '\u\1', 'g')
	let l:clean_first_char = l:name[0] !=# '\u'
	return l:clean_first_char ? toupper(l:name[0]) .. strpart(l:name, 1, strlen(l:name)) : l:name
endfunction
