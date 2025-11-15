" ~/.config/nvim/autoload/snippet.vim

let s:snippet_path = expand("~/.config/nvim/snippets")

function! snippet#Get(type, name, args={}) abort
	let l:begin_line = line(".")
	let l:total_line = line("$")
	let l:snippet_file = join([s:snippet_path, a:type, a:name], "/")
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

function! snippet#Sign(type) abort
	let l:known_types = ["website", "email", "name"]
	if index(l:known_types, a:type) == -1
		echoerr "Unknown signature type: " .. a:type
		return ""
	endif
	let l:signature_path = join([s:snippet_path, a:type], "/")
	return readfile(l:signature_path)[0]
endfunction
