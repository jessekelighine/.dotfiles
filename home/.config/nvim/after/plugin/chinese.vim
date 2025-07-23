" ~/.config/nvim/after/plugin/chinese.vim
" ~/.config/nvim/autoload/chinese.vim

command! -range=% -bang SplitChineseSentence call chinese#SplitSentence(<line1>, <line2>, <bang>0)
command! -range=%       ChineseWordCount     call chinese#WordCount(<line1>, <line2>)
