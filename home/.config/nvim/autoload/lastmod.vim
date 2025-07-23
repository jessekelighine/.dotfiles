" ~/.config/nvim/autoload/lastmod.vim

" DESCRIPTION:
" Change the 'Last Modified' date automatically. The pattern must match the
" entire 'Last Modified' line. The pattern must contain 2 capture groups, the
" 2 groups will be reused at the beginning and the end of the substitution.
"
" EXAMPLE:
" - 'Last Modified' line:    date: "1999-02-10"
" - pattern:                 ^\(date:\s\{-}"\).\{-}\(".*\)$
function! lastmod#Update(pattern, line = min([line("$"), 10])) abort
	let l:pos = getpos(".")
	let l:command = join([
				\ "keepjumps",
				\ "keeppatterns",
				\ "1," .. a:line,
				\ "s/" .. a:pattern .. '/\1' .. strftime("%F") .. '\2/e'
				\ ])
	silent! execute l:command
	silent! call setpos(".", l:pos)
endfunction
