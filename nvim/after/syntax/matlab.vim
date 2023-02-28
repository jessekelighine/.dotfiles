" ~/.config/nvim/after/syntax/matlab.vim

" syntax match MatlabSection "%%.\{-}$"

" highlight def link MatlabSection Type

syntax region MatlabAnonymousFunction matchgroup=MatlabAnonymousFunctionBound start="@\s*(" end=")"
highlight def link MatlabAnonymousFunctionBound Type
