" autoload/cpp.vim

function! cpp#Compile()
	let l:cmd = [ 'gcc',
				\ '-lstdc++',
				\ '-std=c++17',
				\ '-o', expand('%:r').'.o',
				\ expand('%') ]
	silent write
	execut '! ' . join(l:cmd,' ')
	" call terminal#Open(l:cmd)
endfunction
