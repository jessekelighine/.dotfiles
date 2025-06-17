" ~/.config/nvim/autoload/git.vim

" add git conflict markers to matchit list if not already present.
function! <SID>ConflictMatch() abort
	let l:match_words = '\(<<<<<<<\):\(=======\):\(>>>>>>>\)'
	let l:match_words_pattern = escape(l:match_words, '\')
	if !exists("b:match_words")
		let l:match_words = l:match_words .. ","
	elseif matchstrpos(b:match_words, l:match_words_pattern)[1] < 0
		let b:match_words = b:match_words .. l:match_words .. ","
	endif
endfunction

" highlight git merge conflict.
function! git#ConflictHighlight(on)
	call <SID>ConflictMatch()
	if a:on
		syntax match GitConflict /^<<<<<<</
		syntax match GitConflict /^=======/
		syntax match GitConflict /^>>>>>>>/
		highlight GitConflict ctermbg=red ctermfg=white
	else
		syntax clear GitConflict
	endif
	let l:status = a:on ? "ON" : "OFF"
	redraw | echom "--> Git Merge Conflict Highlight: " .. l:status
endfunction
