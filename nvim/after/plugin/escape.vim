" after/plugin/escape.vim

function! <SID>SID()
	return matchstr(expand('<sfile>'),'<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = "\<SNR>".<SID>SID().'_'

function! <SID>setup(bool)
	if a:bool
		let s:showcmd    = &showcmd    | set noshowcmd
		let s:timeoutlen = &timeoutlen | set timeoutlen=30
	else
		let &showcmd    = s:showcmd
		let &timeoutlen = s:timeoutlen
	endif
endfunction

function! <SID>trigger_key(key)
	call <SID>setup(1)
	return s:SID.'work:'.a:key
endfunction

function! <SID>trigger_cancel(key)
	call <SID>setup(0)
	return s:SID.'cancel:'.a:key
endfunction

function! <SID>trigger_success(key)
	call <SID>setup(0)
	return s:SID.'success:'.a:key
endfunction

imap     <expr> j            <SID>trigger_key('j')
imap     <expr> k            <SID>trigger_key('k')
imap     <expr> <SID>work:j  <SID>trigger_cancel('j')
imap     <expr> <SID>work:k  <SID>trigger_cancel('k')
imap     <expr> <SID>work:jk <SID>trigger_success('jk')
imap     <expr> <SID>work:kj <SID>trigger_success('kj')
inoremap <expr> <SID>cancel:j   "j"
inoremap <expr> <SID>cancel:k   "k"
inoremap <expr> <SID>success:jk "\e"
inoremap <expr> <SID>success:kj "\e"
