" ~/.config/nvim/after/plugin/git.vim

" add git conflict markers to matchit list if not already present.
function! <SID>MatchGitConflict() abort
	let l:match_words = '\(<<<<<<<\):\(=======\):\(>>>>>>>\)'
	let l:match_words_pattern = escape(l:match_words, '\')
	if !exists("b:match_words")
		let l:match_words = l:match_words .. ","
	elseif matchstrpos(b:match_words, l:match_words_pattern)[1] < 0
		let b:match_words = b:match_words .. l:match_words .. ","
	endif
endfunction

" check if GitConflict highlight group is active.
function! <SID>GitConflictActive() abort
	if !hlexists("GitConflict")
		return 0
	endif
	let l:highlight_output = execute("highlight GitConflict")
	let l:highlight_status = match(l:highlight_output, "cleared") < 0
	return l:highlight_status
endfunction

" highlight git merge conflict.
function! <SID>ToggleGitConflictHighlight()
	call <SID>MatchGitConflict()
	let l:active = <SID>GitConflictActive()
	if l:active
		highlight clear GitConflict
		syntax clear GitConflict
	else
		syntax match GitConflict /^<<<<<<</
		syntax match GitConflict /^=======/
		syntax match GitConflict /^>>>>>>>/
		highlight GitConflict ctermbg=red ctermfg=white
	endif
	let l:status = !l:active ? "ON" : "OFF"
	redraw | echom "--> Git Merge Conflict Highlight: " .. l:status
endfunction

command! -nargs=0 GitConflictHilightToggle call <SID>ToggleGitConflictHighlight()
