" ~/.config/nvim/after/plugin/titlecase.vim

"" Settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:titlecase_respect_caps = 1
let s:titlecase_respect_caps_in_ignore_words = 0

let s:titlecase_alphabet = '['
			\ .. 'a-z' .. 'A-Z'
			\ .. 'äëïöü' .. 'ÄËÏÖÜ'
			\ .. 'áéíóú' .. 'ÁÉÍÓÚ'
			\ .. 'àèìòù' .. 'ÀÈÌÒÙ'
			\ .. 'āēīōū' .. 'ĀĒĪŌŪ'
			\ .. 'æœÆŒ' .. 'çÇ'
			\ .. ']'

let s:titlecase_ignore_words = []
			\ + ['is', 'are', 'am', 'was', 'were']
			\ + ['a', 'an', 'the', 'that',  'when']
			\ + ['as', 'at', 'by', 'for', 'in', 'on', 'per', 'to', 'via', 'of', 'from', 'with']
			\ + ['and', 'as', 'but', 'if', 'or', 'nor']
			\ + ['v.s.', 'vs.', 'vs', 'en']

"" Functions """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! <SID>Capitalize(word) abort
	return substitute(a:word, s:titlecase_alphabet, '\u\0', '')
endfunction

function! <SID>FormatSubword(word) abort
	let l:clean_word = substitute(a:word, '\s', '', 'g')
	let l:ignore = index(s:titlecase_ignore_words, l:clean_word, 0, !s:titlecase_respect_caps_in_ignore_words) >= 0
	return l:ignore ? a:word : <SID>Capitalize(a:word)
endfunction

function! <SID>FormatWord(word) abort
	let l:subwords = split(a:word, '-')
	let l:output = map(l:subwords, '<SID>FormatSubword(v:val)')
	return join(l:output, '-')
endfunction

function! <SID>Format(sentence) abort
	let l:clean_sentence = s:titlecase_respect_caps ? a:sentence : tolower(a:sentence)
	let l:words = split(l:clean_sentence, '\s\+\zs') " tag spaces at end of words
	let l:output = map(l:words, '<SID>FormatWord(v:val)')
	let l:first_index = match(l:output, s:titlecase_alphabet)
	let l:output[l:first_index] = <SID>Capitalize(l:output[l:first_index])
	return join(l:output, '')
endfunction

"" Main Command """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -range TitleCase :keeppatterns '<,'>s/\%V.*\%V./\=<SID>Format(submatch(0))/
