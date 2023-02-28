" ~/.config/nvim/after/plugin/my.vim

nnoremap <silent> <Plug>(ChineseSpelling)   :call my#ChineseSpelling()<CR>
nnoremap <silent> <Plug>(MakeRoomAbove)     :<C-U>exe "call my#MakeRoom('above',".v:count1.")"<CR>
nnoremap <silent> <Plug>(MakeRoomBelow)     :<C-U>exe "call my#MakeRoom('below',".v:count1.")"<CR>
nnoremap <silent> <Plug>(DeletePair)        :call surround#Delete()<CR>
nnoremap <silent> <Plug>(ToggleLineNumber)  :call my#ToggleLineNumber()<CR>
nnoremap <silent> <Plug>(ToggleVirtualEdit) :call my#ToggleVirtualEdit()<CR>
xnoremap <silent> ia  <Esc>:call my#SelectArgument("i")<CR>
xnoremap <silent> aa  <Esc>:call my#SelectArgument("a")<CR>
onoremap <silent> ia       :call my#SelectArgument("i")<CR>
onoremap <silent> aa       :call my#SelectArgument("a")<CR>
nnoremap <silent> <S-Up>   :call my#Resize2Panes("Up")<CR>
nnoremap <silent> <S-Down> :call my#Resize2Panes("Down")<CR>

command! -nargs=1 TabSize              :call my#TabSize(<args>)
command! -nargs=? LocalVimrc           :call my#LocalVimrc(<args>)
command! -nargs=0 RemoveTrailingSpaces :call my#RemoveTrailingSpaces()
command! -nargs=0 VirtualEditToggle    :call my#ToggleVirtualEdit()
command! -nargs=0 SudoWrite            :writ !sudo tee % > /dev/null " This only works for vim, not neovim.
command! -nargs=0 StatuslineReload     :source $HOME/.config/nvim/after/plugin/statusline.vim
command! -range   ChineseWordCount     :<line1>,<line2>s/[^\x00-\xff]//gn
command! -range -bang SplitChineseSentence :exec <line1>.','.<line2>.'s/\([，。？！；'.eval('<bang>0?"、":""').']\)\n\{0,1}/\1\r/g'
