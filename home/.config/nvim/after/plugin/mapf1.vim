" ~/.config/nvim/after/plugin/mapf1.vim

function! <SID>MapF1() abort
	let l:filetype = &filetype
	let l:ftplugin = "~/.config/nvim/after/ftplugin/" .. l:filetype .. ".vim"
	let l:command = "<Cmd>tabnew " .. l:ftplugin .. "<CR>"
	execute join(["nnoremap", "<buffer>", "<F1>", l:command])
endfunction

augroup MapF1
	autocmd!
	autocmd FileType * call <SID>MapF1()
augroup END
