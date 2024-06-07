" plugin/titlecase.vim

if !exists("g:titlecase_alphabet")
	let g:titlecase_alphabet = '['
				\ .. 'a-z' .. 'A-Z'
				\ .. 'äëïöü' .. 'ÄËÏÖÜ'
				\ .. 'áéíóú' .. 'ÁÉÍÓÚ'
				\ .. 'àèìòù' .. 'ÀÈÌÒÙ'
				\ .. 'āēīōū' .. 'ĀĒĪŌŪ'
				\ .. 'æœÆŒ' .. 'çÇ'
				\ .. ']'
endif

if !exists("g:titlecase_respect_caps")
	let g:titlecase_respect_caps = 1
endif

if !exists("g:titlecase_respect_caps_in_ignore_words")
	let g:titlecase_respect_caps_in_ignore_words = 0
endif

if !exists("g:titlecase_ignore_words")
	let g:titlecase_ignore_words = []
				\ + ['is', 'are', 'am', 'was', 'were']
				\ + ['a', 'an', 'the', 'that']
				\ + ['as', 'at', 'by', 'for', 'in', 'on', 'per', 'to', 'via', 'of']
				\ + ['and', 'as', 'but', 'if', 'or', 'nor']
				\ + ['v.s.', 'vs.', 'vs', 'en']
endif

command! -range TitleCase :keeppatterns '<,'>s/\%V.*\%V./\=titlecase#Format(submatch(0))/
