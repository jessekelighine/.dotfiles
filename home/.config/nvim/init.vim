" ~/.config/nvim/init.vim

filetype plugin on
filetype indent plugin on
syntax on
language en_US.UTF-8

" inoremap jk <Esc>
" inoremap kj <Esc>
" nnoremap <expr> n 'Nn'[v:searchforward]
" nnoremap <expr> N 'nN'[v:searchforward]

" nnoremap Y      y$
nnoremap <Space> <Nop>
nnoremap zS     zszH
nnoremap <Up>   gk
nnoremap <Down> gj
inoremap <C-l> <C-G>u<Esc>[s1z=`]a<C-G>u
xnoremap // y/\V<C-R>=escape(@", '/\')<CR><CR>
xnoremap >  >gv
xnoremap <  <gv
noremap  '' "*y
xnoremap p pgvy
xnoremap <leader>p p

nnoremap <F12> :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <CR> :nohlsearch<CR>:echo ""<CR>
" nnoremap <C-N> :Texplore<CR>
" nnoremap - :Explore<CR>

nnoremap [t :tabprev<CR>
nnoremap ]t :tabnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>
" nnoremap ]q :cnext<CR>
" nnoremap [q :cprevious<CR>
" nnoremap ]Q :clast<CR>
" nnoremap [Q :cfirst<CR>
" nnoremap [b :bprev<CR>
" nnoremap ]b :bnext<CR>
" nnoremap [B :bfirst<CR>
" nnoremap ]B :blast<CR>

xnoremap a' 2i'
xnoremap a" 2i"
xnoremap a` 2i`
onoremap a' 2i'
onoremap a" 2i"
onoremap a` 2i`
onoremap F  vF
onoremap T  vT

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

inoremap <silent> (<CR> <C-R>=getline(".")[col(".")-1]==""?"(\r)\e==\<S-O>":"(\r"<CR>
inoremap <silent> [<CR> <C-R>=getline(".")[col(".")-1]==""?"[\r]\e==\<S-O>":"[\r"<CR>
inoremap <silent> {<CR> <C-R>=getline(".")[col(".")-1]==""?"{\r}\e==\<S-O>":"{\r"<CR>
inoremap (<Tab> ()<Left>
inoremap [<Tab> []<Left>
inoremap {<Tab> {}<Left>
inoremap <<Tab> <><Left>
inoremap )<Tab> ()<Left>
inoremap ]<Tab> []<Left>
inoremap }<Tab> {}<Left>
inoremap ><Tab> <><Left>
inoremap '<Tab> ''<Left>
inoremap `<Tab> ``<Left>
inoremap "<Tab> ""<Left>

set encoding=utf-8
set fileencoding=utf-8
set spelllang=en
set fileformats=unix,dos,mac
set mouse=
set hidden
set noswapfile
set switchbuf=useopen
set autoread
set nowrap
set wildmenu wildignorecase wildoptions=pum
set display=truncate " long line will be displayed rather than '@@@'
set colorcolumn=80,120
set laststatus=2
set scroll=5 scrolloff=1
set number relativenumber nonumber
set backspace=indent,eol,start
set ignorecase smartcase
set hlsearch incsearch
set noerrorbells visualbell t_vb=
set autoindent breakindent
set noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 smarttab
set autochdir
set history=1000
set listchars=tab:┊\ ,trail:–,extends:»,precedes:«,nbsp:␣,eol:¬,space:·
set matchpairs+=（:） mps+=「:」 mps+=『:』 mps+=《:》 mps+=【:】 mps+=〈:〉 mps+=“:”
set splitbelow
set nrformats+=alpha
set nrformats-=bin,hex
set lazyredraw ttyfast
set timeoutlen=500 ttimeoutlen=50
set updatetime=300
set shortmess-=S " Show number of matches.
set notermguicolors
let g:html_number_lines=1

augroup CommentAndIndent
	autocmd!
	autocmd BufNewFile,BufRead * setl formatoptions-=o
	autocmd BufNewFile,BufRead * setl formatoptions+=rn
	autocmd BufNewFile,BufRead * setl formatoptions+=jnmB " line joining for CJK characters
augroup END

if has("nvim")
	tnoremap <silent> <Esc> <C-\><C-n>
	set inccommand=split
	set laststatus=3
	set undofile undodir=~/.config/nvim/undodir/
	set directory^=~/.config/nvim/swap/
	lua require "init"
else
	tnoremap <silent> <Esc><Esc> <C-W><S-N>
	let &t_SI="\e[5 q"
	let &t_EI="\e[2 q"
	let &t_SR="\e[4 q"
	set viminfofile=NONE
	set undofile undodir=~/.vim/undodir/
	set directory^=~/.vim/swap/
	set cursorlineopt=number " ,line
	set termwinsize=0*0
	runtime macros/matchit.vim " match HTML tags
endif
