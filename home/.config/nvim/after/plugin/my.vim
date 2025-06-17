" ~/.config/nvim/after/plugin/my.vim

inoremap <silent> :date<Tab> <C-R>=strftime("%F")<CR>
nnoremap <silent> <leader>s  <Cmd>call my#Spell()<CR>
nnoremap <silent> <leader>n  <Cmd>call my#ToggleLineNumber()<CR>
nnoremap <silent> dm         <Cmd>call surround#Delete()<CR>

nnoremap <silent> [<Space> <Cmd>call my#MakeRoom('above', v:count1)<CR>
nnoremap <silent> ]<Space> <Cmd>call my#MakeRoom('below', v:count1)<CR>

nnoremap <silent> <S-Up>    <Cmd>call my#Resize2Panes("Up")<CR>
nnoremap <silent> <S-Down>  <Cmd>call my#Resize2Panes("Down")<CR>
nnoremap <silent> <S-Left>  <Cmd>call my#Resize2Panes("Left")<CR>
nnoremap <silent> <S-Right> <Cmd>call my#Resize2Panes("Right")<CR>

xnoremap <silent> ia <Esc>:call funcargs#SelectArgument("i")<CR>
xnoremap <silent> aa <Esc>:call funcargs#SelectArgument("a")<CR>
onoremap <silent> ia <Cmd> call funcargs#SelectArgument("i")<CR>
onoremap <silent> aa <Cmd> call funcargs#SelectArgument("a")<CR>

command! -nargs=?       LocalVimrc           call my#LocalVimrc(<args>)
command! -nargs=1       TabSize              call my#TabSize(<args>)
command! -nargs=0       SudoWrite            write !sudo tee % > /dev/null " This only works for vim, not neovim.
command! -nargs=0       VirtualEditToggle    call my#ToggleVirtualEdit()
command! -nargs=0       RemoveTrailingSpaces call my#RemoveTrailingSpaces()
command! -nargs=0 -bang GitConflictHighlight call git#ConflictHighlight(<bang>1)
command! -nargs=0 -bang FocusCursor          call my#FocusCursor(<bang>1)
command! -range=% -bang SplitChineseSentence call chinese#SplitSentence(<line1>, <line2>, <bang>0)
command! -range=%       ChineseWordCount     call chinese#WordCount(<line1>, <line2>)
command! -nargs=?       Scratch              call my#Scratch(<args>)
command! -nargs=?       Spell                call my#Spell(<args>)
command! -nargs=0       FlushRegisters       call my#FlushRegisters()
command! -nargs=*       TallyOpacity         silent ! tally-opacity <args>
