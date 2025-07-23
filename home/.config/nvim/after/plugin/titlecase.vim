" ~/.config/nvim/after/plugin/titlecase.vim

let s:titlecase_respect_caps = 1

let s:titlecase_respect_caps_in_ignored_words = 0

let s:titlecase_split_pattern = '\(' .. join(['\s\+', '/', '-\+'], '\|') .. '\)'

let s:titlecase_alphabet = '['
			\ .. 'a-z' .. 'A-Z'
			\ .. 'äëïöü' .. 'ÄËÏÖÜ'
			\ .. 'áéíóú' .. 'ÁÉÍÓÚ'
			\ .. 'àèìòù' .. 'ÀÈÌÒÙ'
			\ .. 'āēīōū' .. 'ĀĒĪŌŪ'
			\ .. 'æœÆŒ' .. 'çÇ'
			\ .. ']'

let s:titlecase_ignored_words = [
			\ 'a', 'an', 'the', 'that',  'when', 'which', 'is', 'are', 'am', 'was', 'were',
			\ 'as', 'at', 'by', 'for', 'in', 'on', 'per', 'to', 'via', 'of', 'from', 'with',
			\ 'and', 'as', 'but', 'if', 'or', 'nor', 'v.s.', 'vs.', 'vs', 'en',
			\ 'so', 'down', 'into', 'like', 'near', 'off', 'onto', 'out', 'over', 'up', 'upon'
			\ ]

function! <SID>Capitalize(word) abort
	return substitute(a:word, s:titlecase_alphabet, '\u\0', '')
endfunction

function! <SID>FormatWord(word) abort
	let l:ignore = index(s:titlecase_ignored_words, a:word, 0, !s:titlecase_respect_caps_in_ignored_words) >= 0
	return l:ignore ? a:word : <SID>Capitalize(a:word)
endfunction

function! <SID>FormatTaggedWord(word) abort
	let l:separator = matchstr(a:word, s:titlecase_split_pattern .. '$')
	let l:clean_word = substitute(a:word, s:titlecase_split_pattern .. '$', '', '')
	return <SID>FormatWord(l:clean_word) .. l:separator
endfunction

function! <SID>Format(sentence) abort
	let l:clean_sentence = s:titlecase_respect_caps ? a:sentence : tolower(a:sentence)
	let l:tagged_words = split(l:clean_sentence, s:titlecase_split_pattern .. '\zs')
	let l:formatted_words = map(l:tagged_words, { key, val -> <SID>FormatTaggedWord(val) })
	let l:first_index = match(l:formatted_words, s:titlecase_alphabet)
	let l:formatted_words[l:first_index] = <SID>Capitalize(l:formatted_words[l:first_index])
	return join(l:formatted_words, '')
endfunction

command! -range TitleCase :keeppatterns '<,'>s/\%V.*\%V./\=<SID>Format(submatch(0))/
