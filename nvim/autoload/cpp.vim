" autoload/cpp.vim

function! cpp#Compile()
	silent write
	let l:cmd = 'gcc -lstdc++ -std=c++17 -o '
				\ . (expand('%:r')) . '.o '
				\ . (expand('%'))
	execute '! ' . l:cmd
	" call terminal#Open(l:cmd)
endfunction
