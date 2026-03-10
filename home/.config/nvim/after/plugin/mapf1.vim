" ~/.config/nvim/after/plugin/mapf1.vim

function! <SID>MapF1() abort
	let l:ftplugin = expand("~/.config/nvim/after/ftplugin/" ..  &filetype .. ".vim")
	if filereadable(l:ftplugin)
		let l:command = "<Cmd>tabnew " .. l:ftplugin .. "<CR>"
	else
		let l:command = "<Cmd>echo 'No ftplugin for [" .. &filetype .. "]'<CR>"
	endif
	execute join(["nnoremap", "<buffer>", "<F1>", l:command])
endfunction

augroup MapF1
	autocmd!
	autocmd FileType * call <SID>MapF1()
augroup END
