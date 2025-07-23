" ~/.config/nvim/autoload/cpp.vim

function! cpp#Compile()
	silent! write
	let l:command = 'gcc -lstdc++ -std=c++17 -o '
				\ .. expand("%:r") .. '.o '
				\ .. expand("%")
	execute '!' .. l:command
endfunction
