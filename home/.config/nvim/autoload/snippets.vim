" ~/.config/nvim/autoload/snippets.vim

let s:snippets_path = expand("~/.config/nvim/snippets")

function! <SID>DoSnippetIndent(args, begin_line, end_line) abort
	let l:do_action = has_key(a:args, "indent") ? a:args.indent : 1
	if l:do_action
		execute a:begin_line .. "," .. a:end_line .. "norm! v="
	endif
endfunction

function! <SID>DoSnippetBegin(args, begin_line, end_line) abort
	let l:do_action = has_key(a:args, "begin") ? a:args.begin : 1
	if l:do_action
		call cursor(a:begin_line, 0)
	endif
endfunction

function! snippets#Get(type, name, args={}) abort
	let l:begin_line = line(".")
	let l:total_line = line("$")
	let l:snippet_file = join([s:snippets_path, a:type, a:name], "/")
	execute "read " .. l:snippet_file
	execute l:begin_line .. "d"
	let l:end_line = l:begin_line + ( line("$") - l:total_line )
	call <SID>DoSnippetIndent(a:args, l:begin_line, l:end_line)
	call <SID>DoSnippetBegin(a:args, l:begin_line, l:end_line)
endfunction

function! snippets#GetAuthor() abort
	let l:signature_path = join([s:snippets_path, "website"], "/")
	return readfile(l:signature_path)[0]
endfunction
