" ~/.config/nvim/after/plugin/my.vim

inoremap <silent> :date<Tab> <C-R>=strftime("%F")<CR>
nnoremap <silent> [<Space>   :<C-U>exe "call my#MakeRoom('above',".v:count1.")"<CR>
nnoremap <silent> ]<Space>   :<C-U>exe "call my#MakeRoom('below',".v:count1.")"<CR>
nnoremap <silent> <leader>s  :call my#ChineseSpelling()<CR>
nnoremap <silent> <leader>n  :call my#ToggleLineNumber()<CR>
xnoremap <silent> ia    <Esc>:call my#SelectArgument("i")<CR>
xnoremap <silent> aa    <Esc>:call my#SelectArgument("a")<CR>
onoremap <silent> ia         :call my#SelectArgument("i")<CR>
onoremap <silent> aa         :call my#SelectArgument("a")<CR>
nnoremap <silent> <S-Up>     :call my#Resize2Panes("Up")<CR>
nnoremap <silent> <S-Down>   :call my#Resize2Panes("Down")<CR>
nnoremap <silent> <S-Left>   :call my#Resize2Panes("Left")<CR>
nnoremap <silent> <S-Right>  :call my#Resize2Panes("Right")<CR>
nnoremap <silent> dm         :call surround#Delete()<CR>

command! -nargs=?       LocalVimrc           :call my#LocalVimrc(<args>)
command! -nargs=1       TabSize              :call my#TabSize(<args>)
command! -nargs=0       SudoWrite            :write !sudo tee % > /dev/null " This only works for vim, not neovim.
command! -nargs=0       StatuslineReload     :source $HOME/.config/nvim/after/plugin/statusline.vim
command! -nargs=0       VirtualEditToggle    :call my#ToggleVirtualEdit()
command! -nargs=0       RemoveTrailingSpaces :call my#RemoveTrailingSpaces()
command! -nargs=0       GitConflictHighlight :call my#GitConflictHighlight()
command! -nargs=0 -bang FocusCursor          :call my#FocusCursor(<bang>1)
command! -range   -bang SplitChineseSentence :exec <line1>.','.<line2>.'s/\([，。？！；'.eval('<bang>0?"、":""').']\)\n\{0,1}/\1\r/g'
command! -range         ChineseWordCount     :<line1>,<line2>s/[^\x00-\xff]//gn
