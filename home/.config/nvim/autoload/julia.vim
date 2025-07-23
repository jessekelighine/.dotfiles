" ~/.config/nvim/autoload/julia.vim

function! julia#Compile()
	let l:command = 'julia ' .. expand("%")
	silent! write
	execute "!" .. l:command
endfunction
