" ~/.config/nvim/autoload/snippets.vim

let s:snippets_path = expand("~/.config/nvim/snippets")

function! snippets#Get(type, name, args={}) abort
	let l:begin_line = line(".")
	let l:total_line = line("$")
	let l:snippet_file = join([s:snippets_path, a:type, a:name], "/")
	execute "read " .. l:snippet_file
	execute l:begin_line .. "d"
	let l:do = {
				\ "begin": has_key(a:args, "begin") ? a:args.begin : 1,
				\ "indent": has_key(a:args, "indent") ? a:args.indent : 1
				\ }
	if l:do.begin
		call cursor(l:begin_line, 0)
	endif
	if l:do.indent
		let l:pos = getpos(".")
		let l:end_line = l:begin_line + ( line("$") - l:total_line )
		execute l:begin_line .. "," .. l:end_line .. "norm! v="
		call setpos(".", l:pos)
	endif
endfunction

function! snippets#GetAuthor() abort
	let l:signature_path = join([s:snippets_path, "website"], "/")
	return readfile(l:signature_path)[0]
endfunction
