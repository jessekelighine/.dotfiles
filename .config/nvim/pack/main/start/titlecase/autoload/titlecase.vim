" autoload/titlecase.vim

function! <SID>Capitalize(word) abort
	return substitute(a:word, g:titlecase_alphabet, '\u\0', '')
endfunction

function! <SID>FormatSubword(word) abort
	let l:clean_word = substitute(a:word, '\s', '', 'g')
	let l:ignore = index(g:titlecase_ignore_words, l:clean_word, 0, !g:titlecase_respect_caps_in_ignore_words) >= 0
	return l:ignore ? a:word : <SID>Capitalize(a:word)
endfunction

function! <SID>FormatWord(word) abort
	let l:subwords = split(a:word, '-')
	let l:output = map(l:subwords, '<SID>FormatSubword(v:val)')
	return join(l:output, '-')
endfunction

function! titlecase#Format(sentence) abort
	let l:clean_sentence = g:titlecase_respect_caps ? a:sentence : tolower(a:sentence)
	let l:words = split(l:clean_sentence, '\s\+\zs') " keep spaces at end of words
	let l:output = map(l:words, '<SID>FormatWord(v:val)')
	let l:first_index = match(l:output, g:titlecase_alphabet)
	let l:output[l:first_index] = <SID>Capitalize(l:output[l:first_index])
	return join(l:output, '')
endfunction
