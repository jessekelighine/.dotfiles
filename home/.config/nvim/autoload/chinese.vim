" ~/.config/nvim/autoload/chinese.vim
" ~/.config/nvim/after/plugin/chinese.vim

function! chinese#WordCount(line1, line2)
	let l:char_set = "[^\\x00-\\xff]"
	exe a:line1 .. "," .. a:line2 .. "s/" .. l:char_set .. "//gn"
endfunction

function! chinese#SplitSentence(line1, line2, split_dunhao = 0)
	let l:punct_set = ['，', '。', '？', '！', '；']
	let l:punct_set += a:split_dunhao ? ['、'] : []
	let l:command = 's/\([' .. join(l:punct_set, '') .. ']\)\n\{0,1}/\1\r/g'
	exe a:line1 .. "," .. a:line2 .. l:command
endfunction

function! chinese#SetupSpell()
	setlocal spelllang+=cjk
endfunction
