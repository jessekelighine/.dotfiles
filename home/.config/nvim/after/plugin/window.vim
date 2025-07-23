" ~/.config/nvim/after/plugin/window.vim

" Resize Stacking Panes in the Style of Tmux
function! <SID>Resize(direction, size = 5) abort
	let l:up   = win_screenpos(winnr())[0] <= 2
	let l:left = win_screenpos(winnr())[1] <= 1
	if     a:direction == "Up"    | execute      "resize" .. ( l:up   ? "-" : "+" ) .. a:size
	elseif a:direction == "Down"  | execute      "resize" .. ( l:up   ? "+" : "-" ) .. a:size
	elseif a:direction == "Left"  | execute "vert resize" .. ( l:left ? "-" : "+" ) .. a:size
	elseif a:direction == "Right" | execute "vert resize" .. ( l:left ? "+" : "-" ) .. a:size
	endif
endfunction

" Create a Scratch Pane/Tab
function! <SID>Scratch(tab = 0, height = 5) abort
	if a:tab
		tabnew
	else
		new
		execute "resize " .. a:height
	endif
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	setlocal nobuflisted
endfunction

command! -nargs=? -bang Scratch call <SID>Scratch(<bang>0, <args>)

nnoremap <silent> g<Up>     <Cmd>call <SID>Resize("Up", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> g<Down>   <Cmd>call <SID>Resize("Down", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> g<Left>   <Cmd>call <SID>Resize("Left", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> g<Right>  <Cmd>call <SID>Resize("Right", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> <S-Up>    <Cmd>call <SID>Resize("Up", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> <S-Down>  <Cmd>call <SID>Resize("Down", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> <S-Left>  <Cmd>call <SID>Resize("Left", v:count == 0 ? 5 : v:count)<CR>
nnoremap <silent> <S-Right> <Cmd>call <SID>Resize("Right", v:count == 0 ? 5 : v:count)<CR>
