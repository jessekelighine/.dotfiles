" ~/.config/nvim/after/syntax/matlab.vim

" syntax match MatlabSection "%%.\{-}$"

" highlight def link MatlabSection Type

syntax region MatlabAnonymousFunction matchgroup=MatlabAnonymousFunctionBounds start="@\s*(" end=")"
highlight def link MatlabAnonymousFunctionBounds Type
