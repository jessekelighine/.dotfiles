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
function! <SID>ActiveGitConflict() abort
	if !hlexists("GitConflict") | return 0 | endif
	let l:highlight_output = execute("highlight GitConflict")
	let l:highlight_status = match(l:highlight_output, "cleared") < 0
	return l:highlight_status
endfunction

" highlight git merge conflict.
function! <SID>HighlightGitConflict(activate) abort
	if a:activate
		highlight clear GitConflict
		syntax clear GitConflict
	else
		syntax match GitConflict /^<<<<<<</
		syntax match GitConflict /^=======/
		syntax match GitConflict /^>>>>>>>/
		highlight GitConflict ctermbg=red ctermfg=white
	endif
endfunction

" toggle git merge conflict highlight.
function! <SID>ToggleGitConflictHighlight() abort
	call <SID>MatchGitConflict()
	let l:active = <SID>ActiveGitConflict()
	call <SID>HighlightGitConflict(!l:active)
	try
		exec "keepjumps keeppatterns /^<<<<<<<"
	catch
	endtry
	let l:status = !l:active ? "ON" : "OFF"
	redraw | echom "--> Git Merge Conflict Highlight: " .. l:status
endfunction

command! -nargs=0 GitConflictHilightToggle call <SID>ToggleGitConflictHighlight()
